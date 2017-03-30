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
    A_percept = load(sprintf('%s20q_A_percept.mat',dir));
    percept = A_percept.A_percept;
    p = zscore(percept);
    data = sc.data;
    data1 = [];
    tc = load(sprintf('%sLabel.mat',dir));
    words = tc.words;
    labels = tc.labels;
    for z=1:size(data,1) 
        data1 =cat(1,data1,cell2mat(data(z)));
    end;
   data_main = data1;
    % Till now we have obtained the data and labels
    voxels = size(data1,2);
    rep1 = 6;    
   % labels are scattered, so we need to arrange them in 60 * 6 order,
    % Check this method as a part of debug;
    c = 1;
    data3 =[];
    for a = 1:6:360
        data3(a:a+5,:) = squeeze(data1(labels == c,:));
        c = c+1;
    end;
  data = data3;
  data = data';
    % Permute for Voxel * word * repetition format
   A2 = [];
   A2 = zeros(voxels,60,6);
   for n = 1 :voxels
       m = 1;
       for o = 1:60
         A2(n,o,:) = data(n,m:m+5);  
         m = m+6;
       end;
   end;
    size(A2)
    %A2 = zscore(A2,1,1);
    scores = voxel_selection(A2);
    scores(1:10)
    
    data = data_main;
     A_avg =[];
    c = 1;
    for b = 1:60
        A_avg(b,:) = squeeze(mean(data(labels == b,:)));
    end;
    
    data = A_avg;
    data = zscore(data);
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(A_avg));
    size(data)
    data_regress = data;
% Sorting the voxel scores in descending order
Asorted = 0;
AbsoluteIndices_A=0;

    [Asorted,AbsoluteIndices_A] = sort(scores,'descend');
    AbsoluteIndices_A(1:10)
% Selecting top 10% voxel
    voxels = size(data,2);
    toprated_A = voxels * 1;
    A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);

% Removing low scored voxels from data
    voxel_selected_A = [];
%voxel_selected_B = [];

    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,data(:,A_Indices_selected(index,1)));
    end;
    data = voxel_selected_A;
    save(sprintf('%s%s_voxselected.mat',dir2,subj),'data','labels','words','-v7.3');
   
end;