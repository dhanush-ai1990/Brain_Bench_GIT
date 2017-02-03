# The program written to preprocess the Skip Gram file and remove the spaces between word vectors which causes float point division error.


Skip_in= "/Users/Dhanush/Desktop/Projects/Brain_Bench/WordVector/GoogleNews-vectors-negative300.txt"
skip_out="/Users/Dhanush/Desktop/Projects/Brain_Bench/WordVector/Skip_gram_corrected.txt"
f = open(Skip_in,'r')
f.readline()
data = f.read()
output = open(skip_out, "w")
output.write(data)