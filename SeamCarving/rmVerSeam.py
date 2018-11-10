'''
  File name: rmVerSeam.py
  Author: Nehal Doiphode
  Date created: 23/10/2018
'''



import numpy as np


def rmVerSeam(I, Mx, Tbx):
    
    [r, c] = np.shape(Mx)
    Ix = np.zeros(np.shape(I))
    E = Mx.min(1)[r - 1]
    index = np.argmin(Mx[r-1,:] )

    

    for i in range(1, r + 1):
		Ix[r-i, 0:index, :] = I[r-i, 0:index, :]
		Ix[r-i, index:c - 1, :] = I[r-i, index+1:, :]

		index = index + Tbx[r-i, index]
		index = int(index)

    Ix = Ix[:, 0:c-1, :]
    Ix = Ix.astype('uint8')
    return Ix, E
