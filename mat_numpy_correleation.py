
# This program is written to calculate the pearson correlation between each pair of words in Brain Bench MRI dataset.

import scipy.io as sio
import h5py
import numpy as np
from scipy.stats.stats import pearsonr
import sys

#File locations :
outfile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/'
infile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_VoxelDone/'
subjs1 = ['P1','P2','P3','P4','P5','P6','P7','P8','P9']

for i in range(9):
	file_in = infile + str(subjs1[i]) +'_voxselected.mat'
	print file_in
	S1 = h5py.File(file_in)
	Brain_data = S1['data'][()].transpose()
	length = 60
	input_mat = np.empty((length, length))		
	input_mat.fill(0)						# initialize the mattrix made by input word vector

	# calculating correlation and generate the mattrix
	for word1 in range (0,length):
		vector1 = Brain_data[word1,:]
		for word2 in range (0,length):
			vector2 = Brain_data[word2,:]
			#print vector1
			#print vector2
			input_mat[word1][word2] = pearsonr(vector1, vector2)[0]
	# print (input_mat)	
	np.save(outfile+str(subjs1[i])+'_MRI.npy', input_mat)
