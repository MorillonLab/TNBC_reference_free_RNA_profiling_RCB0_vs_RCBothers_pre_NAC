# REFERENCE-FREE RNA PROFILING PREDICTS TRIPLE NEGATIVE BREAST CANCER CHEMORESISTANCE TO NEOADJUVANT TREATMENT


## Scripts
- get gene counts with kallisto (adapt input variables to your own data in "input variables") : https://github.com/MorillonLab/DIS3_analysis/blob/main/getKallistoCounts.sh
- get differential expression in a Leave-P-out cross-validaton fashion (samples of each condition are divided into blocks. For each condition, one block is left-out, and the conditions are compared with a zero-inflated wilcoxon rank test (without the left-out block). The process is reconducted, until all the blocks have been at least once the left-out block. The process is repeated X times, by randomizing the samples :

  1) For each condition, one block is left-out (script : )
     
   ![plot](https://github.com/MorillonLab/TNBC_reference_free_RNA_profiling_RCB0_vs_RCBothers_pre_NAC/blob/main/heatmap_CV_design_5folds_5timesRepeated_CV.pdf)

     
  3) Conditions are compared with a zero-inflated wilcoxon rank test, without the left-out block (script :)




https://github.com/MorillonLab/TNBC_reference_free_RNA_profiling_RCB0_vs_RCBothers_pre_NAC/blob/main/getCrossValidationAnalysis.sh

## Contacts 

marc.gabriel@curie.fr (bioinfo)

nouritza.torossian@chu-orleans.fr (1st author)

antonin.morillon@curie.fr (team leader, last author)



