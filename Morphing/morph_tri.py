'''
  File name: morph_tri.py
  Author: Nehal Doiphode
  Date created: 13-10-2018
'''

'''
  File clarification:
    Image morphing via Triangulation
    - Input im1: source image
    - Input im2: target image
    - Input im1_pts: correspondences coordiantes in the source image
    - Input im2_pts: correspondences coordiantes in the target image
    - Input warp_frac: a vector contains warping parameters
    - Input dissolve_frac: a vector contains cross dissolve parameters

    - Output morphed_im: a set of morphed images obtained from different warp and dissolve parameters.
                         The size should be [number of images, image height, image Width, color channel number]
'''
import numpy as np
from scipy.spatial import Delaunay




def morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac):
  # TODO: Your code here
  # Tips: use Delaunay() function to get Delaunay triangulation;
  # Tips: use tri.find_simplex(pts) to find the triangulation index that pts locates in.
	
  
  total_frames = np.size(warp_frac)
    
  
# 
#  boundary = np.array([[0, 0], [0, 100], [0, 200], [0, 256], [100, 0], [200, 0], [256, 0], [256, 0], [256, 100], [256, 200], [256, 256], \
#    [100, 256], [200, 256]])

#  
  
  #INITIALIZING WARPED IMAGES
  
  im1_warped = np.zeros([total_frames, im1.shape[0], im1.shape[1], im1.shape[2]])
  print(np.shape(im1_warped))
  im2_warped = np.zeros([total_frames, im1.shape[0], im1.shape[1], im1.shape[2]])
  im_morphed = np.zeros([total_frames, im1.shape[0], im1.shape[1], im1.shape[2]])
  
    
  for frame in range(0, total_frames):
      #FINDING THE INTERPOLATED SHAPE BETWEEN POINT CORRESPONDENCES
      t = warp_frac[frame]
      tdis = dissolve_frac[frame]
      interShape_pts = (1-t)*im1_pts + (t)*im2_pts
      
      #DEFINING TRAINGULAR MESH OVER THE POINTS 
      Tri_interShape_pts = Delaunay(interShape_pts)
      
      
      #FINDING  INDEXES AND COORDINATES OF TRIANGLES
      
      ind_interShape = Tri_interShape_pts.simplices
      im1size= np.shape(im1)
      pixInWhichTri = np.zeros((int(im1size[0]), int(im1size[1])))
      
      #FINDING WHICH PIXELS BELONG TO WHICH TRIANGLE FOR INTERPOLATED SHAPE, {stores index of the triangle}
      for i in range(0, np.shape(im1)[0]):
          for j in range(0, np.shape(im1)[1]):
            pixInWhichTri[i,j] =  Tri_interShape_pts.find_simplex(np.array([i, j]))
            
            
      #Going over total triangles in the image      
      for k in range(0,ind_interShape.shape[0]):
          
      #COMPUTING BARYCENTRIC POINTS IN INTERPOLATED IMAGE          
          TriVer_interShape = interShape_pts[Tri_interShape_pts.simplices[k]]
          TriVer_interShape = np.transpose(TriVer_interShape)

          TriVer_interShape = np.r_[TriVer_interShape,np.ones([1, 3])]

          #FIND WHICH POINTS BELONG TO TRIANGLE K
          ptsinTri =  np.where(pixInWhichTri == k)
          x = ptsinTri[0]
          y = ptsinTri[1]
          ptsinTri = np.row_stack((x,y))
          ptsinTri = np.row_stack((ptsinTri, np.ones([1, np.shape(ptsinTri)[1]])))
          bary_coor_interShape = np.dot(np.linalg.inv(TriVer_interShape), ptsinTri)
          
          #FIND CORRESPONDING POINTS IN SOURCE IMAGE
          TriVer_im1 = im1_pts[Tri_interShape_pts.simplices[k]]
          TriVer_im1 = TriVer_im1.transpose()
          TriVer_im1 = np.row_stack((TriVer_im1, np.ones([1, 3])))
  
          
          corres_pts1 = np.dot(TriVer_im1,bary_coor_interShape)
          corres_pts1 = np.floor(corres_pts1/corres_pts1[2,:]).astype(np.int64)
          
          #FIND CORRESPONDING POINTS IN TARGET IMAGE
          TriVer_im2 = im2_pts[Tri_interShape_pts.simplices[k]]
          TriVer_im2 = TriVer_im2.transpose()
          TriVer_im2 = np.row_stack((TriVer_im2, np.ones([1, 3])))
          
          corres_pts2 = np.dot(TriVer_im2,bary_coor_interShape)
          corres_pts2 = np.floor(corres_pts2/corres_pts2[2,:]).astype(np.int64)
          
          #Copy back the pixel value at xs;ys the original (source) image back to the target (intermediate) image.
          #print(np.shape(im1[corres_pts1[0:1,:],corres_pts1[1:2,:],:] ))
          p1 = corres_pts1[0:2,:]
          p2 = corres_pts2[0:2,:]
          
          indp1 = np.where(p1 >= np.shape(im1)[0])
          indp2 = np.where(p2 >= np.shape(im2)[0])
          if np.size(indp1) > 0:
             p1[indp1] = np.shape(im1)[0]-1
          if np.size(indp2) > 0:
             p2[indp2] = np.shape(im2)[0]-1          

# =============================================================================
#           indp10 = np.where(p1[0] >= np.shape(im1)[0])
#           indp11 = np.where(p1[1] >= np.shape(im1)[0])
#           
# 
#           indp20 = np.where(p2[0] >= np.shape(im1)[0])
#           indp21 = np.where(p2[1] >= np.shape(im1)[0])
# 
#           if np.size(indp10) > 0:
#             p1[0][indp10] = np.shape(im1)[0]-1
#             
# 
#           if np.size(indp11) > 0:
#             p1[1][indp11] = np.shape(im1)[0]-1
#           if np.size(indp20) > 0:
#             p2[0][indp20] = np.shape(im1)[0]-1
#           if np.size(indp21) > 0:
#             p2[1][indp21] = np.shape(im1)[0]-1
# =============================================================================
         # print(np.where(p1[1] >= 257))
    
          im1_warped[frame, x,y,:] = im1[p1[1],p1[0],:] 

          im2_warped[frame, x,y,:] = im2[p2[1],p2[0],:]  

          
    #CROSS DISSOLVE 
      
      im_morphed[frame, :, :, :] = (1-tdis) * im1_warped[frame, :, :, :] + (tdis) * im2_warped[frame, :, :, :]
  im_morphed =  np.transpose(im_morphed, (0, 2, 1,3))    
  return im_morphed




