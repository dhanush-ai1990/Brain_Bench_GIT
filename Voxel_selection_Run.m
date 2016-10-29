dir = '/Users/Dhanush/Desktop/Projects/Brain_Bench/GIT_DATA/';
% average the voxels before regressing
%sc = load(sprintf('data-science-P1.mat'));

    sc = load(sprintf('%sAndersonetalJOCN2014_TACL2016_FMRIDAT.mat',dir));
    st = load(sprintf('%sdata-science-P1.mat',dir));
    % Average the voxels for each word before regressing.
    data = sc.Participant(1).datM2;
    data1 = st.data;
    temp1 = [];
for i=1:size(data1,1)
        temp1 =cat(1,temp1,cell2mat(data1(i)));
        %temp1 = [temp;mean(data1(i:i+5,:))];
end;
rep = 5;
rep1 = 6;
%voxel_sel = voxel_selection(temp);

[words1, voxels1] = size(temp1);
[words, voxels2] = size(data);
A = temp1;
B = data;
A1=permute(reshape(A,voxels1,rep1,[]),[1 3 2]);
B1=permute(reshape(B, voxels2,rep,[]),[1,3,2]);
size(A1)
size(B1)

voxel_sel_A1 = voxel_selection(A1);
voxel_sel_B1 = voxel_selection(B1);
size(voxel_sel_A1);
size(voxel_sel_B1);
%voxel_sel_A1(1:10,:);% Original Data
%voxel_sel_B1(1:10,:);% Anderson Data
% Sorting the voxel scores in descending order
[Asorted,AbsoluteIndices_A] = sort(voxel_sel_A1(:),'descend');
[Bsorted,AbsoluteIndices_B] = sort(voxel_sel_B1(:),'descend');
% Selecting top 10% voxel
toprated_A = voxels1 * 0.1;
toprated_B = voxels2 * 0.1;
% selecting top 10% voxel scores and their indices
%A_score_selected = Asorted(1:toprated_A,1);
%B_score_selected = Bsorted(1:toprated_B,1);
%B_score_selected(1:100,1)
A_Indices_selected = AbsoluteIndices_A(1:toprated_A,1);
B_Indices_selected = AbsoluteIndices_B(1:toprated_B,1);

% Removing low scored voxels from data
voxel_selected_A = [];
voxel_selected_B = [];

for index = 1:size(A_Indices_selected,1)
    
    voxel_selected_A =cat(1,voxel_selected_A,A1(A_Indices_selected(index,1),:,:));

end;

for index = 1:size(B_Indices_selected,1)
    
    voxel_selected_B =cat(1,voxel_selected_B,B1(B_Indices_selected(index,1),:,:));

end;
size(voxel_selected_A)
size(voxel_selected_B)
% checking if the selected voxels are indeed the right ones
% Lets do Voxel selection again.

%voxel_sel_temp = voxel_selection(voxel_selected_A);
%voxel_sel_temp(:,:)
%Mbiggest = Msorted(end:-1:end-9)
%A=permute(reshape(voxel_sel_A1,60,rep1,[]),[1,3,2]);
%size(A) 












