#Code to Extract Voxels for different Brain Regions

#Load the Voxels after Regress and brain Region mapping file

import scipy.io as sio
import h5py
import numpy as np
from scipy.stats.stats import pearsonr
import sys

infile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/Numpy_regions/'
infile1='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/Numpy_regions/'
subjs1 = ['P1','P2','P3','P4','P5','P6','P7','P8','P9']
outfile = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/Numpy_regions/'
length = 60

avg_region_count ={}
for i in range(9):
	#Load the Regressed Voxels
	#print "Loading region matrix for user: " + str(i)
	#print " "
	file_in = infile + str(subjs1[i]) +'_voxselected.mat'
	S1 = h5py.File(file_in)
	#print S1
	Brain_data = S1['data'][()].transpose()
	# Load the Brain Region mapping
	file_in = infile1  +'Brain_region_' +  str(subjs1[i]) +'.txt'
	f = open(file_in,'r')
	subj =f.readline()
	region_list = [line.strip() for line in f if line.strip()]
	region_dict ={}


	print ("===========================================================")
	print " "
	print "Voxel count Vs Region for Participant: " + str(i+1)
	#Copy the Voxels to corresponding region dictionaries, there are 114 Unique regions
	for j in range (Brain_data.shape[1]):
		if region_list[j] not in region_dict:
			region_dict[region_list[j]] = []
		region_dict[region_list[j]].append(Brain_data[:,j])

	keys = region_dict.keys()
	keys.sort()


	for key in keys:
		region_dict[key] = np.asarray(region_dict[key]).T
		#print "   " + str(key) + " : " +str(region_dict[key].shape[1])
		if key not in avg_region_count:
			avg_region_count[key] =0
		avg_region_count[key]+=region_dict[key].shape[1]

		#print region_dict[key].shape
	#save_file = infile  + str(subjs1[i]) +'_RegionMapped.mat'
	#sio.savemat(save_file, {'Mapped_Region': region_dict})

	j =1
	print len(region_dict)
	for key in region_dict:
		print "Processing region " + str(j) +" out of 114 of participant " + str(i+1)
		j+=1
		Brain_data =region_dict[key]
		print Brain_data.shape
		input_mat = np.empty((length, length))
		input_mat.fill(0)
		for word1 in range (0,length):
			vector1 = Brain_data[word1,:]
			for word2 in range (0,length):
				vector2 = Brain_data[word2,:]
			#print vector1
			#print vector2
				input_mat[word1][word2] = pearsonr(vector1, vector2)[0]
	# print (input_mat)	
		print input_mat.shape
		np.save(outfile+str(subjs1[i])+ str('_') + str(key)+'_MRI.npy', input_mat)	

print ("===========================================================")
print " AVG VOXELS PER REGION"
print " "
file_out=outfile+ 'avg_voxel_per_region.txt'
f = open(file_out,'w')
keys = avg_region_count.keys()
keys.sort()
for key in keys:
	temp= key + " " + str(int(avg_region_count[key]/9))
	print temp
	f.write(temp+'\n')

f.close()

