'''
  File name: cumMinEngVer.py
  Author: Nehal Doiphode
  Date created: 23/10/2018
'''
import numpy as np
from scipy.signal import convolve2d

def cumMinEngVer(e):
  [r,c] = np.shape(e)
  Mx = e
  Tbx = np.zeros(np.shape(e))
  
  for i in range(1,r):
    Topleft = convolve2d(Mx[i-1:i,:],np.array([[0,0,1]]),mode='same',boundary='fill',fillvalue=np.finfo(np.float64).max)
    Topmiddle = Mx[i-1:i,:]
    Topright = convolve2d(Mx[i-1:i,:],np.array([[1,0,0]]),mode='same',boundary='fill',fillvalue=np.finfo(np.float64).max)
    Top = np.dstack([Topleft,Topmiddle,Topright])
    Topmin = np.amin(Top,axis=2)
    Topmin_index = np.argmin(Top,axis = 2) - 1
    Mx[i,:] = Mx[i,:]+ Topmin[0,:]
    Tbx[i,:] = Topmin_index[0,:]
  return Mx, Tbx
