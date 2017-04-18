dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Meg_Data/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Meg_Data/MEG_VoxelDone/';
dir1 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Meg_data/MEG_RegressDone/';
subjs = {'A','B','C','D','E','F','G','I','J'};
for i = 1:9
    
    fprintf('Begin of Voxel selection for particpant: %i\n',i);
    fprintf('------------------------------------------');
    fprintf('\n');
    subj = subjs{i};
    st = load(sprintf('%s%s_percept_residual_avrg.mat',dir1,subj));
    data1 = st.data;
    words = st.words;
    labels =st.labels;
    rep1 = 20;
    c = 1;
    fprintf('size of input words');
    size(data1)
    
    %There are supposed to be 1200 labels but some are lacking and these
    %words needs to removed from voxel selection
    %count the labels first and isolate words which has less than 20 rep
    label_count = zeros(60,1);
    full_word = 0;
    for w =1:60
        count = 0;
        for x = 1 :length(labels)
            if w==labels(x)
                count = count +1;
            end;
        end;
        label_count(w,:) = count;
        if count == 20
            full_word = full_word + 1;  
        end;   
    end;
    total_labels = full_word * 20;
    data = zeros(total_labels,306,340);
    
    % Arrange the words in the correct order of labels from 1 to 60
    for j = 1:60
        if label_count(j,:) < 20 
            continue
        end;

        for k=1:length(labels)
            if j==labels(k)
                data(c,:) = data1(k,:);
                c = c+1;    
            end;
        end;
    end;
    fprintf('size after sorting');
    size(data)
    %flatten the array
    mag_data_flatten = zeros(total_labels,306*340);
    for k = 1:total_labels
        temp = data(k,:,:);
        mag_data_flatten(k,:,:) = temp(:);   
    end;
    fprintf('size after flatten for voxel selection');
    size(mag_data_flatten)
    % change to voxels * words * repetition.
    
    data = mag_data_flatten';
    A1 = zeros(104040,full_word,20);
   for n = 1 :104040
       m = 1;
       for o = 1:full_word
         A1(n,o,:) = data(n,m:m+19);  
         m = m+20;
       end;
   end;
   fprintf('size after permute for voxel selection');
   size(A1)
   voxel_sel_A1 = voxel_selection(A1);
   [Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
   %Asorted(1:5)
   toprated_A = 104040 * 0.05;
   A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);
   
   %take the original data to account all words
   data = data1;
   data_flatten = zeros(length(labels),306*340);
    
    for k = 1:length(labels)
        temp = data(k,:,:);
        data_flatten(k,:,:) = temp(:);   
    end;
    %take the flattened data and update using voxel scores
    fprintf('size after flatten on original data');
    data = data_flatten;
    size(data)
    
    voxel_selected_A = [];
%voxel_selected_B = [];

    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,data(:,A_Indices_selected(index,1)));
    end;
    fprintf('size after voxel selection');
    size(voxel_selected_A)
    
    A_avg = [];
    for z = 1:60
        A_avg(z,:) = squeeze(mean(voxel_selected_A(labels == z,:)));
    end;
    fprintf('size after average');
    size(A_avg)
    data = A_avg;
    save(sprintf('%s%s_voxselected.mat',dir2,subj),'data','labels','words','-v7.3');
end;