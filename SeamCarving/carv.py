'''
  File name: carv.py
  Author: Nehal Doiphode
  Date created: 23/10/2018
'''


import numpy as np
from genEngMap import genEngMap
from cumMinEngHor import cumMinEngHor
from cumMinEngVer import cumMinEngVer
from rmHorSeam import rmHorSeam
from rmVerSeam import rmVerSeam




def carv(I, nr, nc):
    
    [n,m,d] = np.shape(I)
    T = np.zeros(np.array([nr + 1, nc + 1]))
    Ic = np.zeros(np.array([n - nr , m - nc, 3]))
    table =  np.empty((nr+1,nc+1),dtype=np.ndarray)
    table[0,0] = I
    track = T
    
    for i in range(0, nr + 1):
		for j in range(0, nc + 1):
			if (i == 0 and j == 0):
				T[i, j] = 0
			elif i == 0:
				e = genEngMap(table[i, j - 1])
				[Mx, Tbx] = cumMinEngVer(e)
				[Ix, Ex] = rmVerSeam(table[i, j - 1], Mx, Tbx)
				table[i, j] = Ix
				T[i, j] = T[i, j - 1] + Ex
				track[i,j]=-1
			elif j == 0:
				e = genEngMap(table[i - 1,j ])
				[My, Tby] = cumMinEngHor(e)
				[Iy, Ey] = rmHorSeam(table[i - 1, j], My, Tby)
				table[i, j] = Iy
				T[i, j] = T[i - 1, j] + Ey
				track[i,j]=1
			else:
				e1 = genEngMap(table[i, j - 1])
				e2 = genEngMap(table[i - 1, j])
				[Mx, Tbx] = cumMinEngVer(e1)
				[My, Tby] = cumMinEngHor(e2)
				[Ix, Ex] = rmVerSeam(table[i, j - 1], Mx, Tbx)
				[Iy, Ey] = rmHorSeam(table[i - 1, j], My, Tby)
				if (T[i - 1, j] + Ey <= T[i, j - 1] + Ex):
					table[i, j] = Iy
					T[i, j] = T[i - 1, j] + Ey
					track[i,j]=1
				else:
					table[i, j] = Ix
					T[i, j] = T[i, j - 1] + Ex
					track[i,j]=-1
                    
                    
                    
    vid = []
    [r,c]=[nr,nc]
    
    while track[r,c]!=0:
		if track[r,c]==1:
			vid.append(table[r,c])
			r=r-1
		elif track[r,c]==-1:
			vid.append(table[r,c])
			c=c-1
    vid.append(table[0,0])
    vid.reverse()

    Ic = table[nr,nc]
    return Ic, T, vid
