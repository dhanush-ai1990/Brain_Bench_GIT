%Program to Regress EEG Voxels.
% The raw Voxel inputs are in order channels * labels * Time

%However the input has to be words * channels * time.

dir  = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_data/';
dir1 = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_data/EEG_Raw/';
dir2 ='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/EEG_data/EEG_RegressDone/';
subjs = {'A','B','C','D','E','F','G'};


num_words = 60;
for i = 1:7,
    subj = subjs{i};
    fprintf('%i %s\n',i,datestr(now));
    load(sprintf('%s%s_dataLabels.mat',dir1,subj));
    load(sprintf('%sEEG_percept',dir));
    A_percept =[];
    word_len = word_len';
    size(word_len);
    for z = 1:60
        for y = 1:6
            A_percept =cat(1,A_percept,(word_len(z,:)));
        end;   
    end;
    size(A_percept);
    p = zscore(A_percept);
    %labels are string labels eg S102 and needs to converted to int
    labels = Session.labels;
    
    for z = 1 :length(labels)
    labels{z}(strfind(labels{z}, ' ')) = [];
    labels{z}(strfind(labels{z}, 'S')) = [];
    end;
    S = sprintf('%s ', labels{:});
    labels = sscanf(S, '%f');
    labels1= [];
    for z =1:length(labels)
        labels1(z) = labels(z);
    end;
    label =labels1;
    data1 = Session.data;
    fprintf('data loaded and size of data');
    size(data1)
    fprintf('Permute to words * channels * time');
    data = permute(data1,[3,1,2]);
    data = zscore(data(:,:));
    size(data)
    % we have finally got our labels.Now lets sort the data as per correct
    % order.
    data2 = zeros(size(data));
    labels_sorted = sort(labels);
    c = 1;
    for j = 1:42
       for k=1:length(labels)
            if j==labels(k)
                data2(c,:) = data(k,:);
                c = c+1;
            end;
        end;
    end;
    
    for j = 65:109
       for k=1:length(labels)
            if j==labels(k)
                data2(c,:) = data(k,:);
                c = c+1;
            end;
        end;
    end;
   
    fprintf('After arranging words per order of labels, size of data ');
    data = data2;
    size(data)
    
    %Now we have 87 words but we have concept labels for only 60, so we
    %remove those 27 words from our data.
    labels_sorted; %sorted label list
    voxels = size(data,2)
    data_trimmed = zeros(360,voxels);
    size(data_trimmed)
    c = 1;
    unwanted = [2 4 14 16 23 28 31 34 35 36 39 40 65 68 69 78 79 80 86 91 100 101 103 105 107 108 109];
    %length(unwanted)
    for a = 1:length(labels)
        num = labels_sorted(a);
        if ismember(num, unwanted(:))
            continue
        end;
        data_trimmed(c,:) = data(a,:);
        c = c + 1;
    end;
    data = data_trimmed;
    fprintf('After removing extra concept labels from data, size of data ');
    size(data)
    [weightMatrix, r] = learn_text_from_fmri_kernel_sep_lambda_no_bias( p,data, 1);
    fprintf('%.g\n',median(r))
    p_1 = p;
    p_1(:,end+1)=1;
    x_fit = p_1*weightMatrix;
    data = data - x_fit;
    
    %data = reshape(data,size(Session.data));
    size(data)
    save(sprintf('%s%s_percept_residual_avrg.mat',dir2,subj),'data','labels','-v7.3');  
end