%% Regress after average
dir = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/';

subjs = {'A','B','C','D','E','F','G','I','J'};
for i = 1:1,
    fprintf('%i\n',i);
    subj = subjs{i};
    sc = load(sprintf('%d%s_raw_avrg.mat',dir,subj));
    words = sc.words;
    A_percept = load(sprintf('%d20q_A_percept.mat',dir));
    
    data = zscore(sc.data(:,:));
    size(data)
    p = zscore(A_percept.A_percept);
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(sc.data));
    size(data)
    save(sprintf('/Users/Dhanush/desktop/%s_raw_avrg_percept_residual_test.mat',subj),'data','words','-v7.3');
end

