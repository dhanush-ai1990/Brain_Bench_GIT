dir1  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_Data/A_dataLabels.mat';



sc = load(sprintf(dir1));
data =Session.data;
size(data)
Labels=Session.labels;
size(Labels)