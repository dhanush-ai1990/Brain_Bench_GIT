dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_VoxelDone/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_VoxelDone/';
dir1 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_RegressDone/';
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};

for i = 1:9
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%s%s_raw_notavrg_percept_residual_test.mat',dir1,subj));
    data1 = sc.data;
    words = sc.word;
    %size(words)
    rep = 5; % Repetition of Words in Anderson Data
    [words1, voxels1] = size(data1);
    data = data1;
    size(data)
   data = data';
    % Permute for Voxel * word * repetition format
   A1 = [];
   A1 = zeros(voxels1,70,5);
   for n = 1 :voxels1
       m = 1;
       for o = 1:70
         A1(n,o,:) = data(n,m:m+4);  
         m = m+5;
       end;
   end;
    size(A1)
    voxel_sel_A1 = voxel_selection(A1);% Performing Voxel selection
    size(voxel_sel_A1);
    [Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
    toprated_A = voxels1 * 0.02;
    A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);
    Asorted(1:10)
% Removing low scored voxels from data
    voxel_selected_A = [];

    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,data1(:,A_Indices_selected(index,1)));
    end;
    size(voxel_selected_A)
 
    A_avg = [];

for c=1:5:size(voxel_selected_A,1)
    A_avg =cat(1,A_avg,mean(voxel_selected_A(c:c+4,:)));
end;
    size(A_avg)
    data = A_avg;
    save(sprintf('%s%s_voxselected.mat',dir2,subj),'data','words','-v7.3');
end;





