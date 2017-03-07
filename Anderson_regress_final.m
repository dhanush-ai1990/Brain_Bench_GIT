%% Regress before average
dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_Raw/';
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_RegressDone/';
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
for i = 1:9
    
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%sAndersonetalJOCN2014_TACL2016_FMRIDAT.mat',dir1));
    word = sc.Participant(i).wordC;
    A_percept = zeros(350,1);
    % Calculating the length of each word
    for j = 1:350
        len = length(word{j});
        A_percept(j)= len;
    end;
    data = sc.Participant(i).datM2;
    databck = data;
    data = zscore(data(:,:));
    % do Mean normalisation for regressed features
    p = zscore(A_percept);
    %[weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    %fprintf('%.g\n',median(r))
    %p_1 = p;
    %p_1(:,end+1)=1;
    %x_fit = p_1*weightMatrix;
    %data = data - x_fit;
    %data = reshape(data,size(databck));
    data = databck;
    save(sprintf('%s%s_raw_notavrg_percept_residual_test.mat',dir2,subj),'data','word','-v7.3');
end;