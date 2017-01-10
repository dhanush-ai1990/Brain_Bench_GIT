DICTIONARY = "/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Dictionary/dictionary_org.txt"
#vector = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Word_Vectors/Skipgram.txt'
vector='/Users/Dhanush/Desktop/Projects/Brain_Bench/Word_Vectors/GoogleNews-vectors-negative300.txt'
vector_file = open(vector, 'r')
dictionary = []
input_words = {}
word_vector =[]
for line in (open(DICTIONARY, 'r')):
	dictionary.append(line.strip())
#data = vector_file.readline()
for index, line in enumerate(vector_file):
	tokens = line.strip().split()
	#print tokens
	word = tokens.pop(0)	
	print word									
	if word in dictionary: 						
		input_words[word] = (map(float, tokens))

print input_words.keys()
print len(input_words)
