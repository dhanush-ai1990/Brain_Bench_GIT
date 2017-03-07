% Voxel selection followed by regress and then averaged.
dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_VoxelDone/';
dir1 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_RegressDone/';
dir3='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/';
dir4 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/temp/';
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
for i = 1:9
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%sdata-science-%s.mat',dir3,subj));
    data = sc.data;
    data1 = [];
    tc = load(sprintf('%sLabel.mat',dir));
    words = tc.words;
    labels = tc.labels;
    for z=1:size(data,1) 
        data1 =cat(1,data1,cell2mat(data(z)));
    end;
   
    A_percept = load(sprintf('%s20q_A_percept.mat',dir));
    %Change A_percept for six times for a 360* 11 matrix
    percept = A_percept.A_percept;
    temp =[];
    for z = 1:60
        for y = 1:6
            temp =cat(1,temp,(percept(z,:)));
        end;   
    end;
    p = zscore(temp);
    data = data1;
    data = zscore(data(:,:));
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(data1));
    size(data)
    A_avg =[];
    for j = 1:60
        A_avg(j,:) = squeeze(mean(data(labels == j,:)));
    end;
    data = A_avg;
    
    save(sprintf('%s%s_voxselected.mat',dir4,subj),'data','labels','words','-v7.3');
end;