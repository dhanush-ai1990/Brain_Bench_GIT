#This Program regress out the Visual features for the f mri data. The general Visual features are the length of the word. We use an L2 regression and subtract the weights from the voxels.
from sklearn.linear_model import Ridge
from sklearn.kernel_ridge import KernelRidge
from sklearn.model_selection import GridSearchCV
import scipy.io as sio
import h5py
import scipy.stats as st
from scipy import stats
import numpy as np
# FILE LOCATIONS
dir0 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/'
#Expected input is .mat file with data element which contains the Voxels.
#It is expected to provide separate file for Each participant in the study
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/'
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_RegressDone/'

#NUMBER OF SUBJECTS
subjs1 = ['P1','P2','P3','P4','P5','P6','P7','P8','P9']
num_subj = 9
num_words = 60
num_repetitions = 6
#The below method is optional. It is used to arrange and sort the Voxel data by
#its labels.

#The below function returns all the index of a particular word
def list_duplicates_of(seq,item):
    start_at = -1
    locs = []
    while True:
        try:
            loc = seq.index(item,start_at+1)
        except ValueError:
            break
        else:
            locs.append(loc)
            start_at = loc
    return locs

def kernal_ridge_regression(X,y):
	print X.shape
	print y.shape
	clf = KernelRidge()
	param_grid = {'alpha': [.0000001, .000001 ,.00001 ,.0001 ,.001 ,.01 ,.1 ,.5 ,1 ,5 ,10 ,50]}
	classifier= GridSearchCV(estimator=clf, cv=5 ,param_grid=param_grid)
	classifier.fit(X, y)
	return none

#Load the Label matrix
file_in = dir0 +'Label.mat'
S1 = h5py.File(file_in)
Labels = S1['labels'][()].transpose()
labels = Labels[0].tolist()

#load the Perceptual matrix
file_in = dir0 +'20q_A_percept.mat'
S1 = h5py.File(file_in)
A_percept_loaded = S1['A_percept'][()].transpose() 
A_percept = np.empty(shape=[A_percept_loaded.shape[0]*num_repetitions, A_percept_loaded.shape[1]])
z = 0
for i in range(num_words):
	for j in range(num_repetitions):
		A_percept[z,:]= A_percept_loaded[i]
		z+=1
A_percept=stats.zscore(A_percept, axis=0, ddof=1)

#for i in range(num_subj):

for i in range(1):
	print ("currently processing Subject: " +str(i+1))
	file_in = dir1 + str(subjs1[i]) +'_raw.mat'
	S1 = h5py.File(file_in)
	Brain_data = S1['data'][()].transpose()
	data = Brain_data
	data_sorted_by_labels = np.empty(shape=[Brain_data.shape[0], Brain_data.shape[1]])
	data=stats.zscore(data, axis=0, ddof=1)
	#weight_matrix = kernal_ridge_regression(A_percept,data)

