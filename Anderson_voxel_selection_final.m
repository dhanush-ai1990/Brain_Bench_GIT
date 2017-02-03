dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_VoxelDone/';
dir1 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Anderson_Data/MRI_RegressDone/';
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};

for i = 1:9
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%s%s_raw_notavrg_percept_residual_test.mat',dir1,subj));
    data1 = sc.data;
    words = sc.word;
    size(words)
    rep = 5; % Repetition of Words in Anderson Data
    [words1, voxels1] = size(data1);
    A = data1;
    size(A)
    A1=permute(reshape(A,voxels1,rep,[]),[1 3 2]); % Changing to Voxel x Words x Repetition
    size(A1)
    voxel_sel_A1 = voxel_selection(A1);% Performing Voxel selection
    size(voxel_sel_A1);
    [Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
    toprated_A = voxels1 * .07;
    toprated_A =500;
    A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);

% Removing low scored voxels from data
    voxel_selected_A = [];

    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,A(:,A_Indices_selected(index,1)));
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





