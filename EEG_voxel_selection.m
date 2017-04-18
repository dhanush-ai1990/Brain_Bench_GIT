dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_Data/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_Data/EEG_VoxelDone/';
dir1 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_data/EEG_RegressDone/';
subjs = {'A','B','C','D','E','F','G','I','J'};
for i = 1:7
    
    fprintf('Begin of Voxel selection for particpant: %i\n',i);
    fprintf('------------------------------------------');
    fprintf('\n');
    subj = subjs{i};
    st = load(sprintf('%s%s_percept_residual_avrg.mat',dir1,subj));
    data1 = st.data;
    labels =st.labels;
    rep1 = 6;
    fprintf('size of input data');
    size(data1)
    words = 60;
    voxels = size(data1,2);
    voxels
    % change to voxels * words * repetition.
    
    data = data1';
    A1 = zeros(voxels,words,rep1);
   for n = 1 :voxels
       m = 1;
       for o = 1:words
         A1(n,o,:) = data(n,m:m+5);  
         m = m+6;
       end;
   end;
   fprintf('size after permute for voxel selection');
   size(A1)
   voxel_sel_A1 = voxel_selection(A1);
   %voxel_sel_A1(1:5)
   [Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
   Asorted(1:5)
   toprated_A = voxels * 0.03;
   A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);
   
 
    voxel_selected_A = [];
    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,data1(:,A_Indices_selected(index,1)));
    end;
    fprintf('size after voxel selection');
    size(voxel_selected_A)
    
    A_avg = [];
    for c=1:6:size(voxel_selected_A,1)
        A_avg =cat(1,A_avg,mean(voxel_selected_A(c:c+5,:)));
    end;
    fprintf('size after average');
    size(A_avg)
    data = A_avg;
    save(sprintf('%s%s_voxselected.mat',dir2,subj),'data','-v7.3');
end;