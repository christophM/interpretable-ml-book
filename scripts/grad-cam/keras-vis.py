import keras
import keras.backend
import imp
import matplotlib.pyplot as plt
from matplotlib import gridspec
import numpy as np
import os
import keras.applications.vgg16 as vgg16
from keras.applications.vgg16 import decode_predictions
from tensorflow.keras.preprocessing.image import load_img
from tensorflow.keras import backend as K
from tf_keras_vis.saliency import Saliency
from tf_keras_vis.utils import normalize
import tensorflow as tf
from tf_keras_vis.gradcam import Gradcam


model, preprocess = vgg16.VGG16(), vgg16.preprocess_input
base_dir = os.path.dirname(__file__)
image_path = os.path.join(base_dir, "..", "..", "manuscript", "images")
# Load an image.
img1 = load_img(
    os.path.join(image_path,"dog_and_book.jpeg"), target_size=(224,224))
img2 = load_img(
    os.path.join(image_path, "ramen.jpg"), target_size=(224,224))
img3 = load_img(
    os.path.join(image_path, "octopus.jpeg"), target_size=(224,224))



images = np.asarray([np.array(img1), np.array(img2), np.array(img3)])
image = preprocess(images)

# Top prediction is 'Italian_greyhound', with index 171 according to
# ~/.keras/models/imagenet_class_index.json
# For the ramen it's soup bowl: 809
# Make sure to execute before applying model_modifier
# And this is then how to get the probabilities and top classes:
# decode_predictions(model.predict(image), top = 1)
# Out[23]: 
# [[('n02091032', 'Italian_greyhound', 0.35211313)],
# [('n04263257', 'soup_bowl', 0.49959907)], 
# [('n02526121', 'eel', 0.69820803)]]


fig = plt.figure(figsize=(10,5))
nrows = 1
ncols = 3
f, ax = plt.subplots(nrows=nrows, ncols=ncols)
fig.subplots_adjust(wspace=0, hspace=0)
fs = 10
ax[0].set_title("Greyhound (vanilla)", fontsize=fs)
ax[0].imshow(images[0])

ax[1].set_title("Soup Bowl (vanilla)", fontsize=fs)
ax[1].imshow(images[1])

ax[2].set_title("Eel (vanilla)", fontsize=fs)
ax[2].imshow(images[2])

for i in range(0, ncols):
    ax[i].set_xticks([])
    ax[i].set_yticks([])


plt.tight_layout()
plt.savefig(os.path.join(image_path, 'original-images-classification.png'), bbox_inches='tight')



def loss(output):
    # Italian_greyhound, soup bowl, eel
    return(output[0][921], output[1][809], output[2][390])

def model_modifier(m):
    m.layers[-1].activation = tf.keras.activations.linear
    return m

saliency = Saliency(model,
                    model_modifier=model_modifier,
                    clone=False)

# GradCAM

# VAnilla
saliency_map = saliency(loss, image)
saliency_map_vanilla = normalize(saliency_map)


# SmoothGrad
saliency_map = saliency(loss, image,
                   # TODO: Increase
                   smooth_samples=30,
                   smooth_noise=0.2)
saliency_map_smooth = normalize(saliency_map)


# Generate heatmap with GradCAM
# Create Gradcam object
gradcam = Gradcam(model,
                  model_modifier=model_modifier,
                  clone=False)

cam = gradcam(loss,
              image,
              penultimate_layer=-1, # model.layers number
             )
cam = normalize(cam)

# Single image as example for chapter start
fig = plt.figure()
plt.imshow(saliency_map_vanilla[0], cmap = 'jet')
plt.axis("off")
plt.savefig(os.path.join(image_path, 'vanilla.png'))


fig = plt.figure(figsize=(10,10))
#gs = gridspec.GridSpec(nrows=3, ncols=3, width_ratios=[1,1,1],
#                       wspace=0.0, hspace=0.0, top=0.95, bottom=0.05,
#                       right=0.845)
nrows = 3
ncols = 3
f, ax = plt.subplots(nrows=nrows, ncols=ncols)
fig.subplots_adjust(wspace=0, hspace=0)
fs = 10

ax[0][0].set_title("Greyhound (vanilla)", fontsize=fs)
ax[0][0].imshow(saliency_map_vanilla[0], cmap = 'jet')

ax[0][1].set_title("Soup Bowl (vanilla)", fontsize=fs)
ax[0][1].imshow(saliency_map_vanilla[1], cmap = 'jet')

ax[0][2].set_title("Eel (vanilla)", fontsize=fs)
ax[0][2].imshow(saliency_map_vanilla[2], cmap = 'jet')

ax[1][0].set_title("Greyhound (Smoothgrad)", fontsize=fs)
ax[1][0].imshow(saliency_map_smooth[0], cmap = 'jet')

ax[1][1].set_title("Soup Bowl (Smoothgrad)", fontsize=fs)
ax[1][1].imshow(saliency_map_smooth[1], cmap = 'jet')

ax[1][2].set_title("Eel (Smoothgrad)", fontsize=fs)
ax[1][2].imshow(saliency_map_smooth[2], cmap = 'jet')

ax[2][0].set_title("Greyhound (Grad-Cam)", fontsize=fs)
ax[2][0].imshow(cam[0], cmap = 'jet')

ax[2][1].set_title("Soup Bowl (Grad-Cam)", fontsize=fs)
ax[2][1].imshow(cam[1], cmap = 'jet')

ax[2][2].set_title("Eel (Grad-Cam)", fontsize=fs)
ax[2][2].imshow(cam[2], cmap = 'jet')

for i in range(0, nrows):
    for j in range(0, ncols):
        ax[i][j].set_xticks([])
        ax[i][j].set_yticks([])

plt.tight_layout()
plt.savefig(os.path.join(image_path, 'smoothgrad.png'), bbox_inches='tight')


