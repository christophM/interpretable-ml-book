# Code from here: ttps://github.com/albermax/innvestigate/blob/master/examples/notebooks/imagenet_compare_methods.ipynb

# Begin: Python 2/3 compatibility header small
# Get Python 3 functionality:
from __future__ import\
    absolute_import, print_function, division, unicode_literals
from future.utils import raise_with_traceback, raise_from
# catch exception with: except Exception as e
from builtins import range, map, zip, filter
from io import open
import six
# End: Python 2/3 compatability header small


###############################################################################
###############################################################################
###############################################################################


import imp
import matplotlib.pyplot as plt
import numpy as np
import os
import innvestigate
import innvestigate.utils
import keras.applications.vgg16 as vgg16
from keras.applications.vgg16 import decode_predictions


model, preprocess = vgg16.VGG16(), vgg16.preprocess_input
base_dir = os.path.dirname(__file__)
utils = imp.load_source("utils", os.path.join(base_dir, "utils.py"))
imgnetutils = imp.load_source("utils_imagenet", "utils_imagenet.py")



# Methods we use and some properties.
methods = [
# NAME                    OPT.PARAMS                POSTPROC FXN                TITLE
# Show input.
("input",                 {},                       imgnetutils.image,         "Input"),
# Function
("gradient",              {"postprocess": "abs"},   imgnetutils.graymap,       "Gradient"),
("smoothgrad",            {"augment_by_n": 64, "postprocess": "square"}, imgnetutils.graymap,       "SmoothGrad"),
# Signal
("deconvnet",             {},                       imgnetutils.bk_proj,       "Deconvnet"),
("guided_backprop",       {},                       imgnetutils.bk_proj,       "Guided Backprop",),
#("pattern.net",           {},   imgnetutils.bk_proj,       "PatternNet"),
# Interaction
#("pattern.attribution",   {},   imgnetutils.heatmap,       "PatternAttribution"),
("input_t_gradient",      {},                       imgnetutils.heatmap,       "Input * Gradient"),
("integrated_gradients",  {"steps": 64}, imgnetutils.heatmap,       "Integrated Gradients"),
("lrp.z",                 {},                       imgnetutils.heatmap,       "LRP-Z"),                                                    
("lrp.epsilon",           {"epsilon": 1},           imgnetutils.heatmap,       "LRP-Epsilon"),
("lrp.sequential_preset_a_flat",{"epsilon": 1},     imgnetutils.heatmap,       "LRP-PresetAFlat"),
("lrp.sequential_preset_b_flat",{"epsilon": 1},     imgnetutils.heatmap,       "LRP-PresetBFlat"),
]

###############################################################################
###############################################################################
###############################################################################

def analyze(model, method, image):
    # Create analyzer
    analyzer = innvestigate.create_analyzer(method[0], model, **method[1])

    # Add batch axis and preprocess
    x = preprocess(image[None])
    # Apply analyzer w.r.t. maximum activated output-neuron
    a = analyzer.analyze(x)

    # Aggregate along color channels and normalize to [-1, 1]
    a = a.sum(axis=np.argmax(np.asarray(a.shape) == 3))
    a /= np.max(np.abs(a))
    # Plot
    plt.imshow(a[0], cmap="seismic", clim=(-1, 1))
    plt.axis('off')
    plt.savefig("dog_and_book_" + method[0] + ".png")

if __name__ == "__main__":
    # Load an image.
    # Need to download examples images first.
    # See script in images directory.
    image = utils.load_image(
        os.path.join(base_dir, "..", "..", "manuscript", "images",  "dog_and_book.jpeg"), 224)

    # Code snippet.
    #plt.imshow(image/255)
    #plt.axis('off')
    #plt.savefig("book-keras.png")

    # Get model
    yhat = model.predict(preprocess(image[None]))
    label = decode_predictions(yhat)
    label = label[0][0]
    print('%s (%.2f%%)' % (label[1], label[2]*100))
    # Strip softmax layer
    model = innvestigate.utils.model_wo_softmax(model)
    
    for method in methods:
        print(method[0])
        analyze(model = model, method = method, image = image)
