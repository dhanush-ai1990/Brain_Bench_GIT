%Code to do voxel selection,store the voxel scores, Average and do regress,
%finally apply voxel scores and update.

dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/';
dir2 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_VoxelDone/';

%Load the label matrix and list of words
tc = load(sprintf('%sLabel.mat',dir));
words = tc.words;
labels = tc.labels;
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
for i = 1:1
    fprintf('%i\n',i);
    subj = subjs1{i};
    sc = load(sprintf('%sdata-science-%s.mat',dir1,subj));
    data = sc.data;
    data1 = [];
    for z=1:size(data,1) 
        data1 =cat(1,data1,cell2mat(data(z)));
    end;
    data = data1;
    % By this point you have all the data, labels and words.
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
    fprintf('Data loaded and size before permute\n');
    size(data)
    %data1([29,113,146,181,288,353,21],1:10);
    %data(1:7,1:10)
    A1=permute(reshape(data,voxels1,rep1,[]),[1 3 2]);
    fprintf('Data loaded and size after permute\n');
    size(A1)
    %The below contains the voxel scores.
    voxel_sel_A1 = voxel_selection(A1);
    voxel_sel_A1(1:10,:)
    fprintf('Voxel selection done and size of score matrix\n');
    size(voxel_sel_A1)
    
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
    %By now we have 360 * 11 percept file and 360 * voxels sorted and
    %mean normalized.
    data1 = data;
    data = zscore(data(:,:));
    fprintf('size of data and percept features before regress\n');
    size(data)
    size(temp)
    % Perform Regress
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    data = reshape(data,size(data1));
    fprintf('Size of data after regress\n');
    size(data)
    
    %perform Actual voxel selection
    fprintf('Starting voxel selection score updates\n');
    % Sorting the voxel scores in descending order
    [Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
% Selecting top 10% voxel
    toprated_A = voxels1 * 0.03;
    A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);

% Removing low scored voxels from data
    voxel_selected_A = [];
%voxel_selected_B = [];

    for index = 1:size(A_Indices_selected,1)
        voxel_selected_A =cat(2,voxel_selected_A,data(:,A_Indices_selected(index,1)));
    end;
    fprintf('Size after voxel selection score updates\n');
    size(voxel_selected_A)
 
    A_avg = [];
    
    %for j = 1:60
    %    A_avg(j,:) = squeeze(mean(voxel_selected_A(labels == j,:)));
    %end;
    
    for c=1:6:size(voxel_selected_A,1)
        A_avg =cat(1,A_avg,mean(voxel_selected_A(c:c+5,:)));
    end;
    
    data = A_avg;
    fprintf('After Averaging across words\n');
    size(data)
    %save(sprintf('%s%s_voxselected.mat',dir2,subj),'data','labels','words','-v7.3');
end;
    