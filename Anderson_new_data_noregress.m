%% Regress before average
dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_Raw/';
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_RegressDone/';
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
for i = 1:1
    
    %save(sprintf('%s%s_raw_notavrg_percept_residual_test.mat',dir2,subj),'data','word','-v7.3');
    
    sc1 = load(sprintf('%sAndersonetalTestDataForDhanushJan2017.mat',dir1))
    data2 = sc1.FMRIPerParticipantStruct2017(i).datM2;
    data2(1:5,1:5)
    data3 = zscore(data(:,:));
    data3(1:5,1:5)
    wordvec=sc1.word2vecEnPearsonM2;
    save(sprintf('/Users/Dhanush/Desktop/wordvec.mat'),'wordvec','-v7.3');
end;

