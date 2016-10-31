# Brain_Bench_GIT
Regress and Voxel Selection for Anderson Data


Anderson Dataset:
	- Involved 9 participants and each of them presented with 70 Italian abstract nouns. The participants were under and MRI when these abstract nouns where shown to them. This resulted in a training matrix of (words * voxels) or (70 * 21000). Each word was shown to the participant 5 times separately 
	resulting in a 350 * 21K matrix. The data is matlab struct file(Participant) with two data groups called wordc and datac. The first step is preprocessing as below.


# The processing of the MRI images of the brain starts with the Kernal ridge regression of the voxels.
  - This is because the MRI images( In particular Voxels) contains some visual stimulus which is not part of semantics.
  - These Visual features includes length of words shown to the participant, white pixels on the screen etc, 
    These needs to be regressed out to get the voxels which stands for semantics alona.


  - Original code written in matlab for regression.