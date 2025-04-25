#!/bin/bash

# ----- Parameters ----- #
SNAKEMAKE=/home/marcgabriel/.local/bin/snakemake
SMK=/home/marcgabriel/Downloads/Hugues_cross_validation/marc/make_cross_validation_partitioning/Snakefile

CONFIG="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/cross_validation_method_analysis_RCB0_vs_RCB123_curie_and_canada_5folds5rep_onTrain_01_05_2024_test7.json"

# ----- Parameters ----- #

$SNAKEMAKE -s $SMK --configfile $CONFIG --cores 1 --unlock
$SNAKEMAKE -s $SMK --configfile $CONFIG --cores 1
