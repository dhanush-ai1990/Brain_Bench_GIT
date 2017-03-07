#Program to plot top performing brain region for various word embeddings


import pickle as pkl
#load the pickle object

infile = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/region_score_fmri.p"

region_dictionary = pkl.load(open(infile,"rb"))

skip_gram =region_dictionary['Skip_gram_corrected.txt']
glove =region_dictionary['glove.6B.300d.txt']
rnn =region_dictionary['RNN.txt']
global_context =region_dictionary['Global_context.txt']
non_dist =region_dictionary['Non-Distributional.txt']
cross_lingual = region_dictionary['Cross_lingual.txt']


regionlist = glove.keys()
regionlist.sort()

temp_list = []
avg =0
for key in regionlist:
	avg+= sum(skip_gram[key])/9
	avg+=sum(glove[key])/9
	avg+=sum(rnn[key])/9
	avg+=sum(non_dist[key])/9
	avg+=sum(cross_lingual[key])/9
	if ((avg/5) > 0.6):
		print "================================================"
		print key + "   " 
		print "SkipGram: " +str(sum(skip_gram[key])/9)
		print "Glove: " +str(sum(glove[key])/9)
		print "RNN: " +str(sum(rnn[key])/9)
		print "Non Dist: " +str(sum(non_dist[key])/9)
		print "Cross Lingual: " +str(sum(cross_lingual[key])/9)
	avg =0
