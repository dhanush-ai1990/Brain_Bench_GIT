#Program to load the saved brain region scores and perform statistical analysis


import pickle

load_pickle ="/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/region_score_fmri.p"
f = open(load_pickle, "rb")
source = pickle.load(f)
#print source.keys()
skip_gram_region_list= source['Skip_gram_corrected.txt'].keys()

#print len(skip_gram_region_list)

#print source['Skip_gram_corrected.txt']

#average the scores per region per 9 participants.

avg_skip_gram = {}
avg_glove = {}
avg_rnn ={}
avg_cross = {}
avg_global ={}
avg_nonds = {}
best = 0
for key in skip_gram_region_list:
	avg1  = sum(source['Skip_gram_corrected.txt'][key])/(len(source['Skip_gram_corrected.txt'][key]))
	avg_skip_gram[key] = avg1
	avg2  = sum(source['Cross_lingual.txt'][key])/(len(source['Cross_lingual.txt'][key]))
	avg_cross[key] = avg2
	avg3  = sum(source['glove.6B.300d.txt'][key])/(len(source['glove.6B.300d.txt'][key]))
	avg_glove[key] = avg3
	avg4  = sum(source['Global_context.txt'][key])/(len(source['Global_context.txt'][key]))
	avg_global[key] = avg4
	avg5  = sum(source['RNN.txt'][key])/(len(source['RNN.txt'][key]))
	avg_global[key] = avg5
	avg6  = sum(source['Non-Distributional.txt'][key])/(len(source['Non-Distributional.txt'][key]))
	avg_global[key] = avg6
	average = (avg1+avg2+avg3+avg4+avg5+avg6)/6
	if (average > 0.60):
		best +=1
		print "-----------------------------------------------------"
		print key
		print " "
		print "SkipGram:      " +str(avg1)
		print "CrossLingual:  " +str(avg2)
		print "Glove:         " +str(avg3)
		print "GlobalContext: " +str(avg4)
		print "Rnn:           " +str(avg5)
		print "NonDist:       " +str(avg6)

print "----------------------------------------------------"
print best

