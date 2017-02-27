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
    %p = zscore(temp);
    p =zscore(percept);
    rep1 = 6;
    [words1, voxels1] = size(data1);
    c=1;
    data = zeros(size(data1));
    %Arrange the words as per the labels
    for j = 1:60
        for k=1:360
            if j==labels(k)
                data(c,:) = data1(k,:);
                c = c+1;
            end;
        end;
    end;
    %data1([29,113,146,181,288,353,21],1:10);
    %data(1:7,1:10)
    size(data)
    A1=permute(reshape(data,voxels1,rep1,[]),[1 3 2]);
    size(A1)
    voxel_sel_A1 = voxel_selection(A1);
    size(voxel_sel_A1);
% Sorting the voxel scores in descending order
    [Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
% Selecting top 10% voxel
    toprated_A = voxels1 * 0.03;
    A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);

% Removing low scored voxels from data
    voxel_selected_A = [];
%voxel_selected_B = [];

    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,data1(:,A_Indices_selected(index,1)));
    end;

    size(voxel_selected_A)
    data = voxel_selected_A;
    A_avg = [];
    for j = 1:60
        A_avg(j,:) = squeeze(mean(data(labels == j,:)));
    end;
    data = A_avg;
    
    save(sprintf('%s%s_voxselected.mat',dir4,subj),'data','labels','words','-v7.3');
end;