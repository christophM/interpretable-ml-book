# Code from here: ttps://github.com/albermax/innvestigate/blob/master/examples/notebooks/imagenet_compare_methods.ipynb
import keras
import keras.backend
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

def inverse_graymap(X):
    return imgnetutils.graymap(np.max(X) - X)


# Methods we use and some properties.
methods = [
# NAME                    OPT.PARAMS                POSTPROC FXN                TITLE
# Show input.
("input",                 {},                       imgnetutils.image,         "Input"),
# Function
("gradient",              {"postprocess": "abs"},   inverse_graymap,       "Gradient"),
("smoothgrad",            {"augment_by_n": 64, "postprocess": "square"}, inverse_graymap,       "SmoothGrad"),
# Signal
("deconvnet",             {},                       imgnetutils.bk_proj,       "Deconvnet"),
("guided_backprop",       {},                       imgnetutils.bk_proj,       "Guided Backprop"),
#("pattern.net",           {},   imgnetutils.bk_proj,       "PatternNet"),
# Interaction
("deep_taylor",           {},                       imgnetutils.heatmap,       "Deep Taylor"),
#("pattern.attribution",   {},   imgnetutils.heatmap,       "PatternAttribution"),
("input_t_gradient",      {},                       imgnetutils.heatmap,       "Input * Gradient"),
("integrated_gradients",  {"steps": 64}, imgnetutils.heatmap,       "Integrated Gradients"),
("lrp.z",                 {},                       imgnetutils.heatmap,       "LRP-Z"),                                                    
("lrp.epsilon",           {"epsilon": 1},           imgnetutils.heatmap,       "LRP-Epsilon"),
("lrp.sequential_preset_a_flat",{"epsilon": 1},     imgnetutils.heatmap,       "LRP-PresetAFlat"),
("lrp.sequential_preset_b_flat",{"epsilon": 1},     imgnetutils.heatmap,       "LRP-PresetBFlat"),
]

if __name__ == "__main__":
    # Load an image.
    image = utils.load_image(
        os.path.join(base_dir, "..", "..", "manuscript", "images",  "dog_and_book.jpeg"), 224)

    # Get model
    yhat = model.predict(preprocess(image[None]))
    label = decode_predictions(yhat)
    label = label[0][0]
    print('%s (%.2f%%)' % (label[1], label[2]*100))
    # Strip softmax layer
    model = innvestigate.utils.model_wo_softmax(model)
    for method in methods:
        print(method[0])
        analyzer = innvestigate.create_analyzer(method[0],
                model,
                **method[1])
        if method[0] == "input":
            a = image[None]/255
        else:
            x = preprocess(image[None])
            # use preprocessing from other script
            a = analyzer.analyze(x)
            a = imgnetutils.postprocess(a, "BGRtoRGB", False)
            a = method[2](a)
        plt.imshow(a[0], cmap="seismic", clim=(-1, 1))
        plt.axis('off')
        plt.title(method[3])
        plt.savefig("dog_and_book_" + method[0] + ".png", bbox_inches = "tight")

