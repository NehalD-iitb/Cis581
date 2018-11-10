'''
  File name: cumMinEngHor.py
  Author: Nehal Doiphode
  Date created: 23/10/2018
'''
import numpy as np

def cumMinEngHor(e):


  [r,c] = np.shape(e)
  My = np.zeros((r+2, c))
  Tby = np.zeros((r+2, c))

  y  = np.arange(r+2)
  y_up = y - 1
  y_down = y + 1
  y_up = np.clip(y_up, 0, r + 1)
  y_down = np.clip(y_down, 0, r + 1)
  My[0,:] = 99999
  My[r+1,:] = 99999


  for j in range(1,  c):

    topleftNb = My[y_up, j - 1:j]
    bottomleftNb = My[y_down, j-1:j]
    centerleftNb = My[:, j - 1:j]
    
    AllLeftNb = np.dstack([topleftNb,centerleftNb,bottomleftNb])      
    Leftmin = np.amin(AllLeftNb,axis=2)                           
    Leftmin_index = np.argmin(AllLeftNb,axis=2) - 1                
    My[:,j] = My[:,j] + Leftmin[:,0]
    Tby[:,j] = Leftmin_index[:,0]
    
  My = My[1:r+1,:]
  Tby = Tby[1:r+1,:]

  return My, Tby