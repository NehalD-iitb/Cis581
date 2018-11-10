'''
  File name: click_correspondences.py
  Author: Nehal Doiphode
  Date created: 13-10-2018
'''

'''
  File clarification:
    Click correspondences between two images
    - Input im1: source image
    - Input im2: target image
    - Output im1_pts: correspondences coordiantes in the source image
    - Output im2_pts: correspondences coordiantes in the target image
'''

import matplotlib.pyplot as plt
import numpy as np
from skimage import transform





def click_correspondences(im1, im2):
  '''
    Tips:
      - use 'matplotlib.pyplot.subplot' to create a figure that shows the source and target image together
      - add arguments in the 'imshow' function for better image view
      - use function 'ginput' and click correspondences in two images in turn
      - please check the 'ginput' function documentation carefully
        + determine the number of correspondences by yourself which is the argument of 'ginput' function
        + when using ginput, left click represents selection, right click represents removing the last click
        + click points in two images in turn and once you finish it, the function is supposed to 
          return a NumPy array contains correspondences position in two images
  '''


  im1 = transform.resize(im1, [300, 300])
  im2 = transform.resize(im2, [300, 300])
  plt.subplot(121)  
  plt.imshow(im1)
  plt.subplot(122)
  plt.imshow(im2)
  #6 points each
  N = 12
  pts = plt.ginput(N)
  pts = np.asarray(pts)
  im1_pts = pts[0:N/2]
  im2_pts = pts[N/2:N]
  return im1_pts, im2_pts

  

