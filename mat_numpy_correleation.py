
# This program is written to calculate the pearson correlation between each pair of words in Brain Bench MRI dataset.

import scipy.io as sio
import h5py
import numpy as np
from scipy.stats.stats import pearsonr
import sys

#File locations :

outfile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/'
infile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp/'
subjs1 = ['P1','P2','P3','P4','P5','P6','P7','P8','P9']
length = 60

for i in range(9):
	file_in = infile + str(subjs1[i]) +'_voxselected.mat'
	S1 = h5py.File(file_in)
	#Brain_data = S1['data'][()].transpose()
	Brain_data = S1['data'][()].transpose()
	

	#TEMPORARY CODE ADDED HERE TO SORT THE BRAIN DATA 
	"""
	
	ind =[0,3,1,4,6,7,14,15,16,17,18,66,52,43,29,19,60,21,45,\
	13,37,27,28,30,32,23,24,25,35,5,34,36,54,39,40,41,42,11,46,31,50,12,20,49,51,\
	53,56,55,64,59,8,9,26,2,10,58,44,47,57,62,61,22,33,65,48,67,38,68,69,63]
	print len(ind)

	z = 0
	for k in range(30):
		if k in ind:
			data_sorted[z,:]= Brain_data[ind[k]]
			z+=1
	Brain_data = data_sorted
	print Brain_data
	"""
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
	print input_mat.shape
	np.save(outfile+str(subjs1[i])+'_MRI.npy', input_mat)
