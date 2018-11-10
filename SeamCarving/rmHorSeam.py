'''
  File name: rmHorSeam.py
  Author: Nehal Doiphode
  Date created: 23/10/2018
'''

import numpy as np

def rmHorSeam(I, My, Tby):
    
    [r, c] = np.shape(My)
    Iy = np.zeros(np.shape(I))
    E = My.min(0)[c - 1]
    index = np.argmin(My[r-1,:])


    for j in range(1, c + 1):
        Iy[0:index, c-j, :] = I[0:index, c-j,:]
    	Iy[index:r - 1, c-j, :] = I[index + 1:, c-j, :]
        index = index + Tby[index, c-j]
        index = int(index)

    Iy = Iy[0:r - 1, :, :]
    Iy = Iy.astype('uint8')
    return Iy, E