#Code to Extract Voxels for different Brain Regions

#Load the Voxels after Regress and brain Region mapping file

import scipy.io as sio
import h5py
import numpy as np
from scipy.stats.stats import pearsonr
import sys

infile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_RegressDone/'
infile1='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/'
subjs1 = ['P1','P2','P3','P4','P5','P6','P7','P8','P9']


for i in range(9):
	#Load the Regressed Voxels
	file_in = infile + str(subjs1[i]) +'_raw_notavrg_percept_residual_test.mat'
	S1 = h5py.File(file_in)
	Brain_data = S1['data'][()].transpose()
	# Load the Brain Region mapping
	file_in = infile1  +'Brain_region_' +  str(subjs1[i]) +'.txt'
	f = open(file_in,'r')
	subj =f.readline()
	region_list = [line.strip() for line in f if line.strip()]
	region_dict ={}


	#Copy the Voxels to corresponding region dictionaries, there are 114 Unique regions
	for j in range (Brain_data.shape[1]):
		if region_list[j] not in region_dict:
			region_dict[region_list[j]] = []
		region_dict[region_list[j]].append(Brain_data[:,j])
	save_file = infile  + str(subjs1[i]) +'_RegionMapped.mat'
	sio.savemat(save_file, {'Mapped_Region': region_dict})



