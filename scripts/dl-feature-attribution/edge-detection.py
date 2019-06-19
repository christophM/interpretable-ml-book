import cv2
import os
import numpy as np
from matplotlib import pyplot as plt
import imp

base_dir = os.path.dirname(__file__)
utils = imp.load_source("utils", os.path.join(base_dir, "utils.py"))
base_dir = os.path.dirname(__file__)
img = utils.load_image(
        os.path.join(base_dir, "..", "..", "manuscript", "images",  "dog_and_book.jpeg"), 224)
img = np.uint8(img)
edges = cv2.Canny(img, 200, 400)
edges = np.max(edges) - edges
plt.imshow(edges,cmap = 'gray')
plt.title('Edge Image'), plt.xticks([]), plt.yticks([])
plt.axis('off')
plt.title("Canny Edge Detector")
plt.savefig("dog_and_book_edge.png", bbox_inches = "tight")

