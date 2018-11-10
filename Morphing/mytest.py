from PIL import Image
from click_correspondences import click_correspondences
from morph_tri import morph_tri
import imageio
from skimage import transform
import numpy as np


img1 = np.array(Image.open('F:\UPENN ACADS\CIS581\Project2A\douche.jpg'))
img2 = np.array(Image.open('F:\UPENN ACADS\CIS581\Project2A\kanyewest.jpg'))



im1 = transform.resize(img1, [300, 300])
im2 = transform.resize(img2, [300, 300])
[im1_pts, im2_pts]=click_correspondences(im1, im2)

#ADDING BOUNDARY POINTS TO OUR CORRESPONDENCES

boundary = np.array([[0, 0], [0, 100], [0, 200], [0, 300], [100, 0], [200, 0], [300, 0], [300, 0], [300, 100], [300, 200], [300, 300], \
                                               [100, 300], [200, 300]])

im1_pts = np.row_stack((im1_pts, boundary))
im2_pts = np.row_stack((im2_pts, boundary))

warp_frac=np.arange(0,1,1/60)
dissolve_frac=warp_frac

morphed_im=morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac)

len=np.shape(warp_frac)
res_list=[]
for i in range(0,len[0]):
	res_list.append(morphed_im[i, :, :, :])
imageio.mimsave('./result.gif', res_list)


