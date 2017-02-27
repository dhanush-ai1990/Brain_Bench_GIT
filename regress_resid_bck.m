%% Regress after average
hdir = '/usr1/afyshe/';
ddir = '/usr1/meg/20questions/features/';
subjs = {'A','B','C','D','E','F','G','I','J'};
for i = 1:9,
    fprintf('%i\n',i);
    subj = subjs{i};
    sc = load(sprintf('%s/%s/%s_raw_avrg.mat',ddir,subj,subj));
    words = sc.words;
    A_percept = load(sprintf('%s/fmri/data/joint_nancy/20q_A_percept.mat',hdir));
    
    data = zscore(sc.data(:,:));
    p = zscore(A_percept.A_percept);
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(sc.data));
    save(sprintf('%s/fmri/data/20questions/%s_raw_avrg_percept_residual.mat',hdir,subj),'data','words','-v7.3');
end

%% Regress before average
hdir = '/usr1/afyshe/';
ddir = '/usr1/meg/20questions/parsed/';
subjs = {'A','B','C','D','E','F','G','I','J'};

A_percept = load(sprintf('%s/fmri/data/joint_nancy/20q_A_percept.mat',hdir));
num_words = 60;
for i = 1:9,
    fprintf('%i %s\n',i,datestr(now));
    sc = load(sprintf('%s/%s/%s_sensors_SSSt_SSP_LP50_DS200_tc_noBlinksSSP.mat',ddir,subj,subj));
    words = sc.words;
    time = sc.time;
    sc.data = permute(sc.data,[2 1 3]);
    labels = sc.labels;
    data = zscore(sc.data(:,:));
    
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
    
    mag_data = mag_data - repmat(mean(mag_data(:,:,avrg_win),3),[1,1,time_len]);
    
    labels = 1:num_words;
    data = mag_data;
    save(sprintf('/usr1/afyshe/fmri/data/20questions/%s_percept_residual_avrg.mat',i),'data','labels','words','-v7.3');
    
end
