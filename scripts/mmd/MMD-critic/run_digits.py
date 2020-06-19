# maintained by rajivak@utexas.edu
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import argparse
import os
from data import Data
from mmd import select_criticism_regularized, greedy_select_protos
import matplotlib.pyplot as plt
from pylab import *
from matplotlib import gridspec
from classify import Classifier
#from mpi4py import MPI
import Helper


DATA_DIRECTORY = os.path.join(os.getcwd(), 'data')


##############################################################################################################################
# plotter function to draw the selected prototypes/criticisms
# ARGS :
# xx : the matrix of selected pictures, each row is the representation of the digit picture
# y : true classification of the picture, only used to print in order
# fileprefix: path prefix
# printselectionnumbers : if True, number of selected digits of each type are also outputted in the output file.
# RETURNS: nothing
##############################################################################################################################
def plotfigs2(xx, selectedy, fileprefix=None, printselectionnumbers = False):
    num_selected = np.array([0] * 10)
    for ii in range(10):
        num_selected[ii] = len(np.where(selectedy == (ii + 1))[0])
        print(ii, num_selected[ii])

    totm = np.shape(xx)[0]
    print("number of images being printed %d" %totm)
    perpic_m = 60
    begin_at = 0
    counter = 0
    perrow = 10

    while counter < int(totm/perpic_m) + 1:

        counter += 1
        print("counter %d " % counter)

        offset = 0
        if begin_at == 0:
            offset = 5 # for text about number of protos/crits of each type
        if not printselectionnumbers:
            offset = 0

        # m=m+offset  # for num_selected
        gs = gridspec.GridSpec(int(perpic_m/perrow)+int(offset/perrow),
                               int(perrow), wspace=0.0, hspace=0.0)
        fig = plt.figure()

        if begin_at == 0 and printselectionnumbers:
            ax=fig.add_subplot(gs[0,:])
            ax.text(0.1,0.5,Helper.format_numsel(num_selected))
            ax.axis('off')

        endd = begin_at + offset+ perpic_m
        if endd-offset > totm:
            endd = totm +offset
        print(" begin %d, end %d" %(begin_at + offset, endd))
        for i in np.array(range(begin_at + offset, endd)):
            ax = fig.add_subplot(gs[int(i - begin_at)])
            #ax.imshow(xx[i - offset, :].reshape((16, 16)), cmap="Greys_r")
            ax.imshow(xx[int(i - offset), :].reshape((16, 16)))
            ax.axis('off')

        file = fileprefix+str(counter) + '.png'
        if file is not None:
            # print("saving file")
            plt.savefig(file , dpi=2000)

        begin_at += perpic_m



##############################################################################################################################
# this function makes selects prototypes/criticisms and outputs the respective pictures. Also does 1-NN classification test
# ARGS:
# filename: the path to usps file
# gamma: parameter for the kernel exp( - gamma * \| x1 - x2 \|_2 )
# ktype: kernel type, 0 for global, 1 for local
# outfig: path where selected prototype pictures are outputted, can be None when outputting of pictures is skipped
# critoutfig: path where selected criticism pictures are outputted, can be None
# testfile : path to the test usps.t
# RETURNS: returns indices of  selected prototypes, criticisms and the built data structure that contains the loaded usps dataset
##############################################################################################################################
def run(filename,  gamma, m, k, ktype, outfig, critoutfig,testfile):

    digitsdat = Data()
    digitsdat.load_svmlight(filename, gamma=gamma, docalkernel=False, savefile=None, testfile=testfile, dobin=False)

    if ktype == 0:
        digitsdat.calculate_kernel()
        print("Running Kernel type : global ")
    else:
        digitsdat.calculate_kernel_individual()
        print("Running Kernel type : local ")



    # selected = greedy_parallel(digitsdat.kernel, m)
    # print(np.sort(selected))
    selected = greedy_select_protos(digitsdat.kernel, np.array(range(np.shape(digitsdat.kernel)[0])), m)
    # print(np.sort(selected))
        # critselected = select_criticism(digitsdat.kernel, selected, k)
    selectedy = digitsdat.y[selected]
    sortedindx = np.argsort(selectedy)
    critselected= None

    if outfig is not None:
        plotfigs2(digitsdat.X[selected[sortedindx], :], selectedy[sortedindx], outfig)


    if k > 0:
        critselected = select_criticism_regularized(digitsdat.kernel, selected, k, is_K_sparse=False, reg='logdet')

        critselectedy = digitsdat.y[critselected]
        critsortedindx = np.argsort(critselectedy)

        if critoutfig is not None:
            plotfigs2(digitsdat.X[critselected[critsortedindx], :], critselectedy[critsortedindx], critoutfig+reg)

    return selected, critselected, digitsdat

#########################################################################################################################
# build a 1 NN classifier based on selected prototypes, test it against testfile
# ARGS:
# digitsdat : Data() structure already built. should also have built the kernels and loaded the test file as well.
# selected : the indices of selected prototypes, in order of their selection (the order is important for all_test_k to be viable.
# all_test_m : array of number of prototypes to be used to build classifier. Since the selections are greedy, one can select for 5000 prototypes,
#     and test for num_prototypes = 10, 100, 1000, 4000, etc.
##############################################################################################################################
def test_1NN(digitsdat, selected, all_test_m):

    for testm in all_test_m:

        classifier = Classifier()
        classifier.build_model(digitsdat.X[selected[0:testm], :], digitsdat.y[ selected[0:testm]])
        print("m=%d error=%f" % ( testm, classifier.classify(digitsdat.testX, digitsdat.testy)))

        # uncomment for stats on how many protos were selected for each type of digit.
        #num_selected = np.array([0] * 10)

        #for ii in range(10):
        #   num_selected[ii] = len(np.where(selectedy == (ii + 1))[0])
        #   print(ii, num_selected[ii])


#########################################################################################################################
#########################################################################################################################
#########################################################################################################################
# start here
def main(
      data_prefix,
      output_prefix,
      gamma,
      m,
      alltestm,
      kerneltype,
      do_output_pics):
    ioff()

    outfig = None
    critoutfig = None

    k = 0 # number of criticisms

    if do_output_pics == 1:
        outfig = os.path.join(output_prefix, 'images/%d/protos' % m)
        critoutfig = os.path.join(output_prefix, 'images/%d/crit' % m)

        Helper.dir_exists(outfig)

    selected, critselected, digitsdat = run(
            os.path.join(data_prefix, 'usps'),
            gamma,
            m,
            k,
            kerneltype,
            outfig,
            critoutfig,
            os.path.join(data_prefix, 'usps.t'))

    test_1NN(digitsdat, selected, alltestm)

    print("...done")


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--data_directory",
        type=str,
        default=DATA_DIRECTORY,
        help="The directory that contains data such as the usps file.")
    parser.add_argument(
        "--output_directory",
        type=str,
        default="./figs/",
        help="The directory in which to output data.")
    FLAGS, unparsed = parser.parse_known_args()

    data_prefix = FLAGS.data_directory
    output_prefix = os.path.join(FLAGS.output_directory, "data")
    gamma = 0.026 # kernel parameter, obtained after cross validation

    #m= 4433 # total number of prototypes to select
    #alltestm =  np.array([4433,  3772, 3135, 2493, 1930, 1484, 1145, 960, 828, 715, 643, 584, 492, 410, 329, 286, 219, 185, 130, 110]) # test using these number of prototypes

    m = 50  # total number of prototypes to select
    alltestm = np.array(
        [410, 329, 286, 219, 185, 130,
         110])  # test using these number of prototypes

    do_output_pics = 1
    kernel_type = 1 # 1 for local, 0 for global

    main(data_prefix, output_prefix, gamma, m, alltestm, kernel_type, do_output_pics)





