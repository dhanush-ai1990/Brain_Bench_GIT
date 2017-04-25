%% Regress before average
dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/';
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_RegressDone/';
%The word list is not present in Data Science Raw files. Reading an
%alternate file to get the words
tc = load(sprintf('%sLabel.mat',dir));
words = tc.words;
labels = tc.labels;
subjs = {'A','B','C','D','E','F','G','I','J'};
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
for i = 1:9
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%sdata-science-%s.mat',dir1,subj));
    data = sc.data;
    data1 = [];
    for z=1:size(data,1) 
        data1 =cat(1,data1,cell2mat(data(z)));
    end;
    data = data1;
    size(data)
    A_percept = load(sprintf('%s20q_A_percept.mat',dir));
    data = zscore(data(:,:));
    %Change A_percept for six times for a 360* 11 matrix
    percept = A_percept.A_percept;
    temp =[];
    size(percept)
    for z = 1:60
        for y = 1:6
            temp =cat(1,temp,(percept(z,:)));
        end;   
    end;
    p = zscore(temp);
    size(p)
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(data1));
    size(data)
    save(sprintf('%s%s_raw_notavrg_percept_residual_test.mat',dir2,subj),'data','words','labels','-v7.3');
end

