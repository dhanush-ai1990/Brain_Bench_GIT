# Brain_Bench_GIT
A study of correleation between language representation in Human Brain and Machine representation (word vectors).

We preprocess brain data such as Fmri, Meg, EEG etc which is recorded on subjects exposed to concept stimulus. The processing involves a L2 Kernal ridge regression which removes the visual features and a Voxel selection which selects the most correlated dimensions of the brain data. We then perform pearson correlation on the brain data and Word vectors and perform the two vs two test. The more details on this can be found on our paper:

BrainBench:
A Brain-Image Test Suite for Distributional Semantic Models
https://aclweb.org/anthology/D16-1213
