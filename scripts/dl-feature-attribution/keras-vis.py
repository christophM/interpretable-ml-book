import keras
import keras.backend
import imp
import matplotlib.pyplot as plt
import numpy as np
import os
import keras.applications.vgg16 as vgg16
from keras.applications.vgg16 import decode_predictions
from tensorflow.keras.preprocessing.image import load_img
from tensorflow.keras import backend as K
from tf_keras_vis.saliency import Saliency
from tf_keras_vis.utils import normalize

model, preprocess = vgg16.VGG16(), vgg16.preprocess_input
base_dir = os.path.dirname(__file__)

if __name__ == "__main__":
    # Load an image.
    image = load_img(
        os.path.join(base_dir, "..", "..", "manuscript", "images",
                     "dog_and_book.jpeg"), target_size=(224, 224))
    image = preprocess_input(image)
    # TODO: CONTINUE here: https://github.com/keisen/tf-keras-vis/blob/master/examples/attentions.ipynb
    # TODO: Define loss
    def loss(output):
        return(output[1])

    def model_modifier(m):
        m.layers[-1].activation = tf.keras.activations.linear
        return m
    
    # OLD CODE:
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

# GradCAM

# VAnilla

# SmoothGrad
