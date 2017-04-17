
% This program extracts the voxel coordinates from the MRI dataset. It maps
% it to MNI coords and stores the name of brain region the voxels belong to
% in an array.
path='/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/MRI_Raw/';
subjs1 = {'P1','P2','P3','P4','P5','P6','P7','P8','P9'};
expt.description = 'science';
expt.data_path = 'data';
expt.subject = 'P1';

%for i = 1:1
    %i
    %subj = subjs1{i};
    load( sprintf('%sdata-science-P9.mat',path));
    cols = [];
    tot_voxels=meta.nvoxels;

    for k = 1:tot_voxels
        cols(k) = k;
    end;
    coord = meta.colToCoord(cols,:);
    mni = get_mni_coordinates(coord);
    aal = get_aal_labels(mni);
    fid = fopen('/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/Michell_Data/Numpy_regions/Brain_region_P9.txt','wt');
    fprintf(fid, 'P9');
        fprintf(fid, '\n');
    for z = 1:length(aal)
        fprintf(fid, string(aal{z}));
        fprintf(fid, '\n');
    end
    fclose(fid);
    
    region = cat(1, aal{:});
    region
%save(sprintf('%s%s_brain_region.mat',path,subj),'region','-v7.3');
%end;

