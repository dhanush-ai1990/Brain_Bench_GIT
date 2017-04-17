%Program to Regress MEG Voxels.
% The raw Voxel inputs are in order channels * labels * Time
%However the input has to be words * channels * time.

dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Meg_data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Meg_data/MEG_Raw/';
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Meg_data/MEG_RegressDone/';
subjs = {'A','B','C','D','E','F','G','I','J'};

A_percept = load(sprintf('%s20q_A_percept.mat',dir)); 
num_words = 60;
for i = 1:1,
    subj = subjs{i};
    fprintf('%i %s\n',i,datestr(now));
    sc = load(sprintf('%s%s_sensors_SSSt_SSP_LP50_DS200_tc_noBlinksSSP.mat',dir1,subj));
    words = sc.words;
    time = sc.time;
    size(time)
    size(sc.data)
    data = sc.data;
    
    labels = sc.labels;
    size(data)
    sc.data = permute(data,[2 1 3]);
    data = zscore(sc.data(:,:));
    size(data)
    
    p = zscore(A_percept.A_percept(labels,:));
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(sc.data));
    
     % now take average over words
    mag_data = zeros(num_words,306,length(time));
    for j = 1:num_words,
        mag_data(j,:,:) = squeeze(mean(data(labels == j,:,:)));
    end
    avrg_win = time >=-0.2 & time <=0;
    
    mag_data = mag_data - repmat(mean(mag_data(:,:,avrg_win),3),[1,1,length(time)]);
    
    labels = 1:num_words;
    data = mag_data;
    save(sprintf('%s%s_percept_residual_avrg.mat',dir1,subj),'data','labels','words','-v7.3');  
end