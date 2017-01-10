%% Regress before average
dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/';
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/';
%The word list is not present in Data Science Raw files. Reading an
%alternate file to get the words
tc = load(sprintf('%stemp.mat',dir));
words = tc.words;
labels = tc.labels;
A_percept = load(sprintf('%s20q_A_percept.mat',dir));
A_percept = A_percept.A_percept
A_percept(1:1,:)
p = zscore(A_percept(:,:));
p(1:1,:)
subjs = {'A','B','C','D','E','F','G','I','J'};
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
for i = 1:3
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%sdata-science-%s.mat',dir1,subj));
    data = sc.data;
    data1 = [];
    for z=1:size(data,1) 
        data1 =cat(1,data1,cell2mat(data(z)));
    end;
    data = data1;

    data = zscore(data(:,:));
    data(1:5,1:5)
    size(data)
    %save(sprintf('%s%s_raw.mat',dir2,subj),'data','-v7.3');
end