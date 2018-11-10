
'''
  File name: cumMinEngVer.py
  Author: Nehal Doiphode
  Date created: 23/10/2018
'''

import numpy as np
from PIL import Image
from carv import carv
import matplotlib.pyplot as plt

import imageio



I = np.array(Image.open('./test/test2.jpg'))
fig1=plt.figure(1)
plt.imshow(I)

nr=10 
nc=25 
[Ic, T, vid]=carv(I, nr, nc)

fig2=plt.figure(2)
plt.imshow(Ic)
plt.show()
fig2.savefig('result.jpg')
imageio.mimsave('./result.gif', vid)