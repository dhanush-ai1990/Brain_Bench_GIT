import scipy.io as sio
import h5py
import numpy as np
from scipy.stats.stats import pearsonr
import sys


P1_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P1_MRI.npy"
P2_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P2_MRI.npy"
P3_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P3_MRI.npy"
P4_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P4_MRI.npy"
P5_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P5_MRI.npy"
P6_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P6_MRI.npy"
P7_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P7_MRI.npy"
P8_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P8_MRI.npy"
P9_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/NewNumpy/P9_MRI.npy"
"""
P1_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P1_MRI.npy"
P2_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P2_MRI.npy"
P3_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P3_MRI.npy"
P4_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P4_MRI.npy"
P5_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P5_MRI.npy"
P6_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P6_MRI.npy"
P7_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P7_MRI.npy"
P8_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P8_MRI.npy"
P9_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp1/P9_MRI.npy"

P1_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P1_MRI.npy"
P2_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P2_MRI.npy"
P3_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P3_MRI.npy"
P4_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P4_MRI.npy"
P5_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P5_MRI.npy"
P6_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P6_MRI.npy"
P7_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P7_MRI.npy"
P8_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P8_MRI.npy"
P9_MAT = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/NewNumpy/P9_MRI.npy"

A_MAT = "./corr_mats/MEG/a.npy"
B_MAT = "./corr_mats/MEG/b.npy"
C_MAT = "./corr_mats/MEG/c.npy"
D_MAT = "./corr_mats/MEG/d.npy"
E_MAT = "./corr_mats/MEG/e.npy"
F_MAT = "./corr_mats/MEG/f.npy"
G_MAT = "./corr_mats/MEG/g.npy"
I_MAT = "./corr_mats/MEG/i.npy"
J_MAT = "./corr_mats/MEG/j.npy"
"""
DICTIONARY ="/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/Dictionary/dictionary_org.txt"
#DICTIONARY = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/Dictionary/Anderson_words.txt"
#DICTIONARY = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/Dictionary/A.txt"
word_vec_in ="/Users/Dhanush/Desktop/Projects/Brain_Bench/Word_Vectors/"
size_words = 60
def get_matrix_and_mask(vector_file):
	unavailable = []	# list of indexes of word in brain data that did not appear in the input
	word_vector = []	# input word vector

	# dic for dictionary
	dictionary = {}
	for line in (open(DICTIONARY, 'r')):
		dictionary[line.strip()] = 0
	#print dictionary
	# dic for input vectors
	input_words = {}
	# filter out words from the input that is not in the dictionary
	count = 0
	for index, line in enumerate(vector_file):
		tokens = line.strip().split()
		word = tokens.pop(0)
		count+=1;
		word = word.lower()										
		if word in dictionary: 						
			input_words[word] = (map(float, tokens))
	#print len(dictionary)
	# find words that is in dictionary but not in the input, record their indexs for making a mask
	for i, line in enumerate(open(DICTIONARY, 'r')):
		if line.strip() not in input_words: 
			unavailable.append(i) 
	keylist = input_words.keys()
	keylist.sort()
	for key in keylist:
	    word_vector.append(input_words[key])
	#print len(keylist)
	    # print "%s: %s" % (key, input_words[key])
	# print word_vector

	word_vector = np.array(word_vector)		# cast word vector from a list of list to an array
	length = word_vector.shape[0]		
	# get the length of the word vector
	input_mat = np.empty((length, length))		
	input_mat.fill(0)						# initialize the mattrix made by input word vector

	# calculating correlation and generate the mattrix
	for word1 in range (0,length):
		vector1 = word_vector[word1,:]
		for word2 in range (0,length):
			vector2 = word_vector[word2,:]
			#print vector1
			#print vector2
			input_mat[word1][word2] = pearsonr(vector1, vector2)[0]
	# print (input_mat)

	#create mask
	mask = np.ones((size_words,size_words), dtype=bool)
	for i in range(0, size_words):
		for j in range(0,size_words):
			if (i in unavailable) or (j in unavailable):
				mask[i,j] = False
	# print mask 

	length = len(word_vector)
	return {
		'input_mat' : input_mat,
		'mask' : mask,
		'length' : length
	}

def two_vs_two (input_mat, brain_mat, length):
	brain_1 = input_mat
	brain_2 = brain_mat
	#brain_2 = np.load(open(brain_2_name, 'r'))
	s = 0
	total = 0

	for line_a in range (0,length):
		b_1_a = brain_1[line_a,:]
		b_2_a = brain_2[line_a,:]
		for line_b in range (line_a+1, length):
			b_1_b = brain_1[line_b,:]
			b_2_b = brain_2[line_b,:]
			mask = np.ones(len(b_1_a), dtype=bool)
			mask[[line_a, line_b]] = False
			#b_1_a_masked = ma.masked_array(b_1_a, mask = mask)
			#b_2_a_masked = ma.masked_array(b_2_a, mask = mask)
			#b_1_b_masked = ma.masked_array(b_1_b, mask = mask)
			#b_2_b_masked = ma.masked_array(b_2_b, mask = mask)
			b_1_a_masked = b_1_a[mask]
			b_2_a_masked = b_2_a[mask]
			b_1_b_masked = b_1_b[mask]
			b_2_b_masked = b_2_b[mask]
			#print mask
			#print len(b_2_b_masked)
			#print mask

			part_a = pearsonr(b_1_a_masked, b_2_a_masked)[0] + pearsonr(b_1_b_masked, b_2_b_masked)[0]
			part_b = pearsonr(b_1_a_masked, b_2_b_masked)[0] + pearsonr(b_1_b_masked, b_2_a_masked)[0]
			# part_a = distance.cosine(b_1_a_masked, b_2_a_masked) + distance.cosine(b_1_b_masked, b_2_b_masked)
			# part_b = distance.cosine(b_1_a_masked, b_2_b_masked) + distance.cosine(b_1_b_masked, b_2_a_masked)
			
			#print part_a
			#print part_b

			total += 1
			if part_a > part_b:
				s += 1		
	#print s/float(total)	
	# print "%d out of %d" % (s, total)
	return s/float(total)


def get_score(input_mat, brain_data_filename, mask, length):
	brain_file = open(brain_data_filename, 'r')
	brain_mat = np.load(brain_file)
	brain_mat = np.reshape(brain_mat[mask], (length, length))
	return two_vs_two(input_mat, brain_mat, length)


def get_fMRI_average(input_mat, mask, length):
	fMRI_score = get_score(input_mat,  P1_MAT, mask, length)
	fMRI_score += get_score(input_mat, P2_MAT, mask, length)
	fMRI_score += get_score(input_mat, P3_MAT, mask, length)
	fMRI_score += get_score(input_mat, P4_MAT, mask, length)
	fMRI_score += get_score(input_mat, P5_MAT, mask, length)
	fMRI_score += get_score(input_mat, P6_MAT, mask, length)
	fMRI_score += get_score(input_mat, P7_MAT, mask, length)
	fMRI_score += get_score(input_mat, P8_MAT, mask, length)
	fMRI_score += get_score(input_mat, P9_MAT, mask, length)
	return fMRI_score/9.0
	#return fMRI_score/7.0

def get_MEG_average(input_mat, mask, length):
	MEG_score = get_score(input_mat, A_MAT, mask, length)
	MEG_score += get_score(input_mat, B_MAT, mask, length)
	MEG_score += get_score(input_mat, C_MAT, mask, length)
	MEG_score += get_score(input_mat, D_MAT, mask, length)
	MEG_score += get_score(input_mat, E_MAT, mask, length)
	MEG_score += get_score(input_mat, F_MAT, mask, length)
	MEG_score += get_score(input_mat, G_MAT, mask, length)
	MEG_score += get_score(input_mat, I_MAT, mask, length)
	MEG_score += get_score(input_mat, J_MAT, mask, length)
	return MEG_score/9.0

def run_test (input_file):
	obj = get_matrix_and_mask(input_file)
	input_mat = obj['input_mat']
	mask = obj['mask']
	length = obj['length']
	fMRI_score = 0
	fMRI_score = get_fMRI_average(input_mat, mask, length)
	MEG_score = 0
	#MEG_score = get_MEG_average(input_mat, mask, length)

	return [fMRI_score, MEG_score, length]

def main():
	#input_file_list =['Global_context.txt','Skip_gram_corrected.txt','RNN.txt','Cross_lingual.txt','glove.6B.300d.txt','Non-Distributional.txt']
	input_file_list =['Global_context.txt','Skipgram.txt','RNN.txt','Cross_lingual.txt','glove.6B.300d.txt','Non-Distributional.txt']
	for z in range(6):
		print "Running test for:  " + str(input_file_list[z])
		input_vec = word_vec_in +str(input_file_list[z])
		input_file= open(input_vec,'r')
		#scores = run_test(open(sys.argv[1], 'r'))
		scores = run_test(input_file)
		print "There are %d words found in BrainBench from the input" % scores[2]
		print "The fMRI score is %f" % scores[0]
	#print "The MEG score is %f" % scores[1]

if __name__ == "__main__":
    main()