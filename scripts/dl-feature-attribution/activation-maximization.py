# code from here: https://gist.github.com/saurabhpal97/158988f112e2e3b6067d25c5f6499ef3#file-activation_max-py

#importing the required modules
from vis.visualization import visualize_activation
from vis.utils import utils
from keras import activations
from keras import applications
import matplotlib.pyplot as plt
from scipy.misc import imread

plt.rcParams['figure.figsize'] = (18,6)
#creating a VGG16 model using fully connected layers also because then we can 
#visualize the patterns for individual category
from keras.applications import VGG16
model = VGG16(weights='imagenet',include_top=True)

#finding out the layer index using layer name
#the find_layer_idx function accepts the model and name of layer as parameters and return the index of respective layer
layer_idx = utils.find_layer_idx(model,'predictions')
#changing the activation of the layer to linear
model.layers[layer_idx].activation = activations.linear
#applying modifications to the model
model = utils.apply_modifications(model)
#Indian elephant
img3 = visualize_activation(model,layer_idx,filter_indices=385,max_iter=5000,verbose=True)
plt.imshow(img3)
