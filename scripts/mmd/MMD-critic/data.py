# maintained by rajivak@utexas.edu
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from sklearn.datasets import load_svmlight_file
import numpy as np
from sklearn.datasets import load_svmlight_file
from sklearn.metrics.pairwise import rbf_kernel


# class to load and handle data
class Data:
    X = None # n * d
    y = None # n
    gamma = None
    kernel  = None # n* n

    def __init__(self):
        pass

    # only to perform cross validation for picking gamma
    def splittraintest(self, testpercent):
        ntest = int(np.shape(self.X)[0] * testpercent/100.0)
        testindices = np.random.choice(np.shape(self.X)[0], ntest, replace=False)
        self.testX = self.X[testindices, :]
        self.testy = self.y[testindices]
        trainindices = np.setdiff1d(np.arange(np.shape(self.X)[0]), testindices)
        self.X = self.X[trainindices,:]
        self.y = self.y[trainindices]


    def subset(self, i):
        return np.where(y==i)[0]

    def load_data(self, X, y, gamma=None, docalkernel=False, savefile=None, testfile=None, dobin=False):
      self.X = X
      if dobin:
          bins = [-1.0, -0.67, -0.33, 0, 0.33, 0.67, 1.0]
          # bins = [-1.0, 0, 1.0]
          binned  = np.digitize(self.X, bins )
          self.X=np.array([bins[binned[i, j] - 1] for i in range(np.shape(self.X)[0]) for j in range(np.shape(self.X)[1])]).reshape(np.shape(self.X))

      self.y = y
      if testfile is not None:
          dat2 = load_svmlight_file(testfile)
          self.testX = dat2[0].todense()
          if dobin:
              bins = [-1.0, -0.67, -0.33, 0, 0.33, 0.67, 1.0]
              binned = np.digitize(self.testX, bins)
              self.testX = np.array([bins[binned[i, j] - 1] for i in range(np.shape(self.testX)[0]) for j in range(np.shape(self.testX)[1])]).reshape(np.shape(self.testX))

          self.testy = dat2[1]
      # print(np.shape(self.X))

      self.gamma = gamma
      self.kernel = rbf_kernel(self.X, gamma=gamma)

    def load_svmlight(self, filename, gamma=None, docalkernel=False, savefile=None, testfile=None, dobin=False):
        data = load_svmlight_file(filename)
        self.load_data(data[0].todense(), data[1], gamma, docalkernel, savefile, testfile, dobin)

    def calculate_kernel(self, g=None):
        if g is None:
            if self.gamma is None:
                print("gamma not provided!")
                exit(1)
            else:
                self.kernel = rbf_kernel(self.X, gamma=self.gamma)
        else:
            self.kernel = rbf_kernel(self.X, gamma=g)

    # only calculate distance within class. across class, distance = 0
    def calculate_kernel_individual(self, g=None):
        touseg = g
        if touseg is None:
            touseg = self.gamma
        if touseg is None:
            print("gamma not provided!")
            exit(1)
        self.kernel = np.zeros((np.shape(self.X)[0], np.shape(self.X)[0]) )
        sortind = np.argsort(self.y)
        self.X = self.X[sortind, :]
        self.y = self.y[sortind]

        for i in np.arange(10):
            j = i+1
            ind = np.where(self.y == j)[0]
            startind = np.min(ind)
            endind = np.max(ind)+1
            self.kernel[startind:endind, startind:endind ] = rbf_kernel(self.X[startind:endind, :], gamma=self.gamma)


    def loadstate(self,filename):
        temp = np.load(filename)
        self.X = temp['X']
        self.y = temp['y']
        self.gamma = temp['gamma']
        self.kernel = temp['kernel']

    def setgamma(self, newgamma):
        if self.kernel is not None:
            temp = np.log(self.kernel)
            temp = temp * newgamma/self.gamma
            self.kernel = np.exp(temp)
        self.gamma = newgamma
        if self.kernel is None:
            self.calculate_kernel()

    def savestate(self, outpfile):
        np.savez(file=outpfile, X=self.X, y=self.y, gamma=self.gamma, kernel=self.kernel)

    def rbf(v1,v2):
        dd = v1 - v2
        res = - self.gamma * np.dot(dd,dd)
        return math.exp(res)

    def getsim(self, i, j):
        if kernel is not None:
            return self.kernel[i,j]
        else:
            return self.rbf(X[i,:], X[j,:])


if __name__ == "__main__":
    import matplotlib.pyplot as plt
    file = 'data/usps'
    data=load_svmlight_file(file)
    X = data[0].todense()
    print(data[1])
    plt.imshow(X[2,:].reshape((16,16)))
    plt.show()




