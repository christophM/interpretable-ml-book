# maintained by rajivak@utexas.edu
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

# simple class to build 1NN classifier and classify using it
class Classifier:
    model=None

    def __init__(self):
        pass

    def build_model(self, trainX, trainy):
        print("building model using %d points " %len(trainy))
        self.model = KNeighborsClassifier(n_neighbors=1)
        self.model.fit(trainX, trainy)

    def classify(self, testX, testy):

        print("classifying %d points " %len(testy))
        predy = self.model.predict(testX)

        ncorrect = np.sum(predy == testy)
        return 1.0 - ncorrect/(len(predy) + 0.0)
