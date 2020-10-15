# maintained by rajivak@utexas.edu
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import os

import numpy as np

def format_numsel(numsel):
    ss = ''
    for i,j in enumerate(numsel):
        ss = ss + " %d:%d " %(i,j)
    return ss

def get_train_testindices(n, ntest, seed):
    np.random.seed(seed)
    testindices = np.random.choice(n,ntest,replace=False)
    trainindices = np.setdiff1d( range(n), testindices)
    return trainindices, testindices

def exit(str):
    print(str)
    exit(1)


def dir_exists(filename):
    """Creates the directory of a file if the directory does not exist.
    
    Raises:
      IOError: If the directory could not be created (and the directory does not
          exist). This may be due to for instance permissions issues or a race
          condition in which the directory is created right before makdirs runs.
    """
    dir = os.path.dirname(filename)
    if not os.path.exists(dir):
        os.makedirs(dir)
