
Scores reported by paper:
===========================

Global_context : 62.0
Skip_gram_corrected:65.1
RNN: 62.1
Cross_lingual: 63.5
Glove: 64.0
Non-Distributional:59.5


Regress, Followed by voxel selection with 3% voxels and then averaged.
======================================================================

Global_context : 656183
Skip_gram_corrected:0.600816
RNN: 0.659071
Cross_lingual: 0.693597
Glove: 0.694036
Non-Distributional:0.624796


Voxel selection with 3% voxels followed by regress and then avg
=================================================================
Global_context : 0.640615
Skip_gram_corrected:0.584432
RNN: 0.658067
Cross_lingual: 0.683804
Glove: 0.679535
Non-Distributional:0.619335

Voxel selection with 3% voxels,averaged and regress
===================================================

Global_context : 0.549153
Skip_gram_corrected:0.473321
RNN: 0.544256
Cross_lingual: 0.516698
Glove: 0.529944
Non-Distributional: Didnt run

Without Regress, VOxel selection and averaged
==============================================

Global_context : 0.609416
Skip_gram_corrected:0.574137
RNN: 0.616698
Cross_lingual: 0.639297
Glove: 0.629818
Non-Distributional: 0.58386




Without Voxel selection,regress using all voxels and averaged
=============================================================

Global_context : 0.670496
Skip_gram_corrected:0.616008
RNN: 0.670810
Cross_lingual: 0.711864
Glove: 0.710044
Non-Distributional: 0.645574

Conclusion: Regress is more important that Voxel selection.
Question: How was higher accuracy obtained for Skip gram ??
=================================================================

Top performing brain regions Avg voxels greater than 100 and avg score >0.6
===========================================================================
Total 26 regions:
================================================
Calcarine_L   
SkipGram: 0.637727558067
Glove: 0.681042059008
RNN: 0.66252354049
Non Dist: 0.628060263653
Cross Lingual: 0.694350282486
================================================
Calcarine_R   
SkipGram: 0.64996861268
Glove: 0.664155681105
RNN: 0.64739485248
Non Dist: 0.623540489642
Cross Lingual: 0.690521029504
================================================
Cerebelum_4_5_L   
SkipGram: 0.6
Glove: 0.688449466416
RNN: 0.631261770245
Non Dist: 0.62172002511
Cross Lingual: 0.660326428123
================================================
Cerebelum_4_5_R   
SkipGram: 0.573383553045
Glove: 0.654551161331
RNN: 0.5934086629
Non Dist: 0.615065913371
Cross Lingual: 0.635028248588
================================================
Cerebelum_6_L   
SkipGram: 0.574387947269
Glove: 0.650596359071
RNN: 0.614626490898
Non Dist: 0.58750784683
Cross Lingual: 0.654174513497
================================================
Cerebelum_6_R   
SkipGram: 0.617200251099
Glove: 0.655430006277
RNN: 0.5868173258
Non Dist: 0.60853735091
Cross Lingual: 0.662209667294
================================================
Cingulum_Mid_L   
SkipGram: 0.541494036409
Glove: 0.639987445072
RNN: 0.615630885122
Non Dist: 0.588888888889
Cross Lingual: 0.625988700565
================================================
Cuneus_R   
SkipGram: 0.605963590709
Glove: 0.627746390458
RNN: 0.628248587571
Non Dist: 0.592153170119
Cross Lingual: 0.640426867546
================================================
Frontal_Inf_Tri_L   
SkipGram: 0.554551161331
Glove: 0.627181418707
RNN: 0.607784055242
Non Dist: 0.595103578154
Cross Lingual: 0.637413684871
================================================
Fusiform_L   
SkipGram: 0.671186440678
Glove: 0.769554300063
RNN: 0.697865662272
Non Dist: 0.68549905838
Cross Lingual: 0.771123666039
================================================
Fusiform_R   
SkipGram: 0.681544256121
Glove: 0.753672316384
RNN: 0.670935342122
Non Dist: 0.702448210923
Cross Lingual: 0.747708725675
================================================
Lingual_L   
SkipGram: 0.597614563716
Glove: 0.660326428123
RNN: 0.655430006277
Non Dist: 0.625423728814
Cross Lingual: 0.665097300691
================================================
Lingual_R   
SkipGram: 0.626741996234
Glove: 0.670684243566
RNN: 0.627809165097
Non Dist: 0.618330194601
Cross Lingual: 0.685436283741
================================================
Occipital_Inf_L   
SkipGram: 0.633772755807
Glove: 0.701381042059
RNN: 0.661644695543
Non Dist: 0.647959824231
Cross Lingual: 0.705524168236
================================================
Occipital_Mid_L   
SkipGram: 0.691650973007
Glove: 0.753170119272
RNN: 0.695794099184
Non Dist: 0.712743251726
Cross Lingual: 0.771939736347
================================================
Occipital_Mid_R   
SkipGram: 0.636095417451
Glove: 0.707281858129
RNN: 0.665599497803
Non Dist: 0.666854990584
Cross Lingual: 0.706654111739
================================================
Occipital_Sup_L   
SkipGram: 0.584243565599
Glove: 0.652793471438
RNN: 0.623477715003
Non Dist: 0.619774011299
Cross Lingual: 0.675266792216
================================================
Occipital_Sup_R   
SkipGram: 0.626239799121
Glove: 0.657564344005
RNN: 0.632517263026
Non Dist: 0.607846829881
Cross Lingual: 0.682674199623
================================================
Parietal_Inf_L   
SkipGram: 0.578719397363
Glove: 0.66252354049
RNN: 0.644444444444
Non Dist: 0.583176396736
Cross Lingual: 0.670433145009
================================================
Parietal_Sup_L   
SkipGram: 0.560451977401
Glove: 0.658254865035
RNN: 0.588386691777
Non Dist: 0.5776522285
Cross Lingual: 0.669993722536
================================================
Precuneus_L   
SkipGram: 0.558443188952
Glove: 0.653609541745
RNN: 0.629943502825
Non Dist: 0.600941619586
Cross Lingual: 0.666917765223
================================================
Precuneus_R   
SkipGram: 0.549780288763
Glove: 0.643126177024
RNN: 0.630634023854
Non Dist: 0.591776522285
Cross Lingual: 0.65329566855
================================================
SupraMarginal_L   
SkipGram: 0.583364720653
Glove: 0.65988700565
RNN: 0.652102950408
Non Dist: 0.607281858129
Cross Lingual: 0.669617074702
================================================
Temporal_Inf_R   
SkipGram: 0.594350282486
Glove: 0.617827997489
RNN: 0.593157564344
Non Dist: 0.595919648462
Cross Lingual: 0.618204645323
================================================
Temporal_Mid_L   
SkipGram: 0.576020087884
Glove: 0.644444444444
RNN: 0.608474576271
Non Dist: 0.587696170747
Cross Lingual: 0.625988700565
================================================
Temporal_Mid_R   
SkipGram: 0.56647834275
Glove: 0.635655994978
RNN: 0.59604519774
Non Dist: 0.586440677966
Cross Lingual: 0.626804770873
==============================================


Some Tests on Anderson Data
==========================

Best performance with regress and Voxel selection at 17% voxels
================================================================
Running test for:  Global_context.txt
There are 65 words found in BrainBench from the input
The fMRI score is 0.563515
Running test for:  Skip_gram_corrected.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.570163
Running test for:  RNN.txt
There are 62 words found in BrainBench from the input
The fMRI score is 0.592514
Running test for:  Cross_lingual.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.614556
Running test for:  glove.6B.300d.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.624139
Running test for:  Non-Distributional.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.562393

No regress and just voxel selection
===================================

The fMRI score is 0.583868
Running test for:  Skip_gram_corrected.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.580989
Running test for:  RNN.txt
There are 62 words found in BrainBench from the input
The fMRI score is 0.611728
Running test for:  Cross_lingual.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.624242
Running test for:  glove.6B.300d.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.639264
Running test for:  Non-Distributional.txt
There are 66 words found in BrainBench from the input
The fMRI score is 0.568143
Observation
===========
However better results with no Regress and just voxels selection
which is not agreeing with what we saw with data science dat





Concrete only for Anderson Data, 30 words from tools, location and social role
=========================================================================
Running test for:  Global_context.txt
There are 26 words found in BrainBench from the input
The fMRI score is 0.587692
Running test for:  Skip_gram_corrected.txt
There are 27 words found in BrainBench from the input
The fMRI score is 0.562520
Running test for:  RNN.txt
There are 25 words found in BrainBench from the input
The fMRI score is 0.620741
Running test for:  Cross_lingual.txt
There are 27 words found in BrainBench from the input
The fMRI score is 0.624881
Running test for:  glove.6B.300d.txt
There are 27 words found in BrainBench from the input
The fMRI score is 0.648306
Running test for:  Non-Distributional.txt
There are 27 words found in BrainBench from the input
The fMRI score is 0.597024

Abstract only for Anderson Data
====================================================================
There are 39 words found in BrainBench from the input
The fMRI score is 0.564103
Running test for:  Skip_gram_corrected.txt
There are 39 words found in BrainBench from the input
The fMRI score is 0.565752
Running test for:  RNN.txt
There are 37 words found in BrainBench from the input
The fMRI score is 0.556890
Running test for:  Cross_lingual.txt
There are 39 words found in BrainBench from the input
The fMRI score is 0.577148
Running test for:  glove.6B.300d.txt
There are 39 words found in BrainBench from the input
The fMRI score is 0.598141
Running test for:  Non-Distributional.txt
There are 39 words found in BrainBench from the input
The fMRI score is 0.541760
====================================================================
MEG data, need the not averaged version to compare it with EEG data
Time labels not provided for EEG data.



