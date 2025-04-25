#!/bin/bash


###### input variables ##########
#################################

#cond1 name
#cond1_name="RCB0"
#cond1_name="healthy"
cond1_name="BPH_or_healthy"

#cond1_name="Hyperplasia"

#cond2 name
#cond2_name="RCBothers"
cond2_name="tumor"

#train_set_input_dir="/media/marcgabriel/saylar9/Nouritza_DESeq2_batch123_without_10BadSamples_batchesInfoIncluded_22_02_2023/Hugues_cross_validation_method_analysis_RCB0_vs_RCB123_curie_and_canada/"
#train_set_input_dir="/media/marcgabriel/saylar9/Nouritza_DESeq2_batch123_without_10BadSamples_batchesInfoIncluded_22_02_2023/Hugues_cross_validation_method_analysis_RCB0_vs_RCB123_curie_and_canada_10folds5rep/"
#train_set_input_dir="/media/marcgabriel/saylar18/classic_10_folds_CV_Nouritza_RCB0_vs_RCB123_curie_and_canada/"
#train_set_input_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/cross_validation_method_analysis_RCB0_vs_RCB123_curie_and_canada_5folds10rep_onTrain/"
#train_set_input_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60/CV_design_dir/"
#train_set_input_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/CV_design_dir/"
#train_set_input_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/CV_design_dir/"

#train_set_input_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/CV_design_dir/"


#train_set_input_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/CV_design_hyperplasia_vs_tumor_dir/"

train_set_input_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/CV_design_63samples_BPH_or_healthy_vs_tumor_dir/"

#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers_proper_end.tsv.gz"
#matrix_file="/media/marcgabriel/saylar9/Nouritza_DESeq2_batch123_without_10BadSamples_batchesInfoIncluded_22_02_2023/DESeq_norm_curie_canada_RCB0_vs_RCBothers/raw_counts_matrix.tsv"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers_proper_end_1kkk.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/kmers_train_counts_matrix.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/kmers_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_genes/genes_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60/kmers_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/genes_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/genes_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_kmers/kmers_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_kmers_test7/kmers_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/genes_train_counts_matrix_10countsinAtLeast5samples.tsv.gz"

#matrix_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/allKmers_counts_healthy_vs_tumor.tsv.gz"
#matrix_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/allKmers_counts_hyperplasia_vs_tumor.tsv.gz"

#matrix_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/allKmers_counts_healthy_vs_tumor.tsv.gz"

matrix_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/BPH_or_healthy_vs_tumor.tsv.gz"


#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers/total_kmers_RCB0_vs_RCBothers.tsv"
#norm_factors_file="/media/marcgabriel/saylar9/Nouritza_DESeq2_batch123_without_10BadSamples_batchesInfoIncluded_22_02_2023/DESeq_norm_curie_canada_RCB0_vs_RCBothers/total_gene_counts_curie_canada_RCB0_vs_RCBothers.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/tot_kmers_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_genes/tot_genes_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60/tot_kmers_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/tot_genes_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/tot_genes_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_kmers/tot_kmers_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_kmers_test7/tot_kmers_10countsinAtLeast5samples.tsv"
#norm_factors_file="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/tot_genes_10countsinAtLeast5samples.tsv"

#norm_factors_file="/media/marcgabriel/saylar10/jellyfish_index_gencode32/all_selected_sequences_meansOfmeans.tsv"

#norm_factors_file="/media/marcgabriel/saylar10/jellyfish_index_gencode32_hyperplasia_vs_tumor/all_selected_sequences_meansOfmeans.tsv"

#norm_factors_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/transcript_counts/healthy_vs_tumor_10TranscriptsMeanCounts.tsv"

#norm_factors_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/transcript_counts/hyperplasia_vs_tumor_10TranscriptsMeanCounts.tsv"
#norm_factors_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/total_kmers_file_hyperplasia_vs_tumor.tsv"

#norm_factors_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/total_kmers_file_healthy_vs_tumor.tsv"

norm_factors_file="/media/marcgabriel/saylar14/Anna_Hope_kmers/median_counts_10_transcripts_63_samples_BPH_healthy_tumor.tsv"

#output_dir="/media/marcgabriel/saylar19/Nouritza_kmers_CV_results_test_stat3.3_Curie_and_canada_RCB0_vs_RCBothers_v2/"
#output_dir="/media/marcgabriel/saylar19/Nouritza_genes_CV_results_test_stat3.3_Curie_and_canada_RCB0_vs_RCBothers_v2/"
#output_dir="/media/marcgabriel/saylar19/Nouritza_genes_CV_results_Curie_and_canada_RCB0_vs_RCBothers_10folds5rep/"
#output_dir="/media/marcgabriel/saylar19/Nouritza_kmers_CV_results_Curie_and_canada_RCB0_vs_RCBothers_10folds5rep/"
#output_dir="/media/marcgabriel/saylar19/Nouritza_kmers_test1kkk_CV_results_Curie_and_canada_RCB0_vs_RCBothers_10folds1rep/"
#output_dir="/media/marcgabriel/saylar19/Nouritza_kmers_test1kkk_CV_results_Curie_and_canada_RCB0_vs_RCBothers_10folds5rep/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/CV_RCB0_vs_RCB123_curie_and_canada_5folds5rep_onTrain_kmers_results/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/CV_RCB0_vs_RCB123_curie_and_canada_5folds5rep_onTrain_kmers_results_10countsinAtLeast5samples/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_genes/CV_RCB0_vs_RCB123_curie_and_canada_5folds5rep_onTrain_genes_results_10countsinAtLeast5samples/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/CV_RCB0_vs_RCB123_curie_and_canada_5folds5rep_onTrain_kmers_results_10countsinAtLeast5samples_pval0_05/"

#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60/CV_5Folds5reps_kmers_pval0.05/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/CV_5Folds5reps_genes_pval0.05/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes/CV_5Folds5reps_genes_pval0.05/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_kmers/CV_5Folds5reps_kmers_pval0.05/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_kmers_test7/CV_5Folds5reps_kmers_pval0.05/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/CV_5Folds5reps_genes_pval0.05/"

#output_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/cross_validation_results_healthy_vs_tumor/"
#output_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/cross_validation_results_hyperplasia_vs_tumor/"

#output_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/cross_validation_results_hyperplasia_vs_tumor_CPM_normalisation/"

#output_dir="/media/marcgabriel/saylar22/Anna_Hope_kmers_cross_validation_results_hyperplasia_vs_tumor/"

#output_dir="/media/marcgabriel/saylar14/Anna_Hope_kmers/cross_validation_results_healthy_vs_tumor_CPM_normalisation/"

output_dir="/media/marcgabriel/saylar26/5times5fold_Selection_BPH_or_healthy_vs_tumor_63Samples/"


#R script to compute ZIW
getZIW_rscript="/home/marcgabriel/Desktop/scripts/getZIWfromValues.R"

#awk script to isolate cond1 and cond2 counts (according to their position), normalize them, and feed getZIW_rscript
getGroupedCounts="/home/marcgabriel/Desktop/scripts/getGroupedCounts.awk"

nb_process=25
#nb_process=15

#pvalue_threshold=0.001
pvalue_threshold=0.05


#pvalue_threshold=3.3

######################################



###### process variables ##########
###################################

output_dir="${output_dir}/"
output_dir=$(echo $output_dir |sed 's/\/\//\//g')
if [ ! -d $output_dir ]; then mkdir -p $output_dir; fi 


#if norm file present, give 1 million to CPX (CPX = counts per X)
if [[ -f $norm_factors_file ]];then

  #for nouritza
  #CPX=1000000
  
  
  #for Anna
  CPX=1

#if no norm file, give 1 to CPX
else

  
  CPX=1

fi

######################################




>${output_dir}parallel_commands.sh


#take all train data
train_list=($(find $train_set_input_dir -name "*train*"|grep -E "train[0-9]+_[0-9]+\.tsv"|sort -V))

echo -e "\nall train list : ${train_list[*]}\n\n"

#loop across train files
for one_train_pos in $(seq 0 $((${#train_list[*]}-1)) );do


        #select one train file
		my_train_set=${train_list[$one_train_pos]}
		
		#echo -e "\n-> train $my_train_set\n"

        #select all samples of cond1
		all_samples_cond1_name=($(grep -P "\t$cond1_name$" $my_train_set|cut -f1))

        #array that will contain position of all samples cond1
		all_samples_cond1_pos=()
		
		
		#array that will contain norm factors associated to cond1 samples
		all_norm_factors_cond1=()

        #for each sample of cond1, store their position in the matrix file, and also their associated norm factor
		for one_sample in ${all_samples_cond1_name[*]};do

                #check if it's gzip matrix, then take the pos of the sample in the header of the matrix
                if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

					all_samples_cond1_pos+=($(zcat $matrix_file |head -n1|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
				
				
				else
				
					all_samples_cond1_pos+=($(head -n1 $matrix_file|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
				
				fi
				
				#if no norm factors, just put 1
				if [[ -f $norm_factors_file ]];then
				
						all_norm_factors_cond1+=($(grep -E "^${one_sample}\s" $norm_factors_file|awk '{print $2}'))
						
				else
				
						all_norm_factors_cond1+=(1)
				
				
				fi
				

		 done

        #separate the values by comma
		all_samples_cond1_pos=$(echo -e "${all_samples_cond1_pos[*]}"|sed 's/ /,/g')
		all_norm_factors_cond1=$(echo -e "${all_norm_factors_cond1[*]}"|sed 's/ /,/g')


        #select all samples of cond2
		all_samples_cond2_name=($(grep -P "\t$cond2_name$" $my_train_set|cut -f1))

        #array that will contain position of all samples cond2
		all_samples_cond2_pos=()

        #array that will contain norm factors associated to cond2 samples
		all_norm_factors_cond2=()

        #for each sample of cond1, store their position in the matrix file, and also their associated norm factor
		for one_sample in ${all_samples_cond2_name[*]};do
		
		        #check if it's gzip matrix, then take the pos of the sample in the header of the matrix
		        if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then


					all_samples_cond2_pos+=($(zcat $matrix_file |head -n1|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
				
				
				else
				
					all_samples_cond2_pos+=($(head -n1 $matrix_file|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
				
				fi
				
				#if no norm factors, just put 1
				if [[ -f $norm_factors_file ]];then
				
				
						all_norm_factors_cond2+=($(grep -E "^${one_sample}\s" $norm_factors_file|awk '{print $2}'))
						
				else
				
						all_norm_factors_cond2+=(1)
				
				
				fi


		done

        #separate the values by comma
		all_samples_cond2_pos=$(echo -e "${all_samples_cond2_pos[*]}"|sed 's/ /,/g')
		all_norm_factors_cond2=$(echo -e "${all_norm_factors_cond2[*]}"|sed 's/ /,/g')

		#echo -e "\n\t-> all cond1 counts pos : $all_samples_cond1_pos ; total counts : $all_norm_factors_cond1\n\n"

		#echo -e "\n\t-> all cond2 counts pos : $all_samples_cond2_pos ; total counts : $all_norm_factors_cond2\n\n"
		
		
		if [[ ! -f ${output_dir}train${one_train_pos}_result.tsv.gz ]];then
		
		
		        echo -e "no ${output_dir}train${one_train_pos}_result.tsv.gz files...\n\n"
		
		
				#check if the matrix file is gzip compressed, then process it
				if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then
				
				   #the idea is to isolate counts belonging to cond1 and counts belonging to cond2, normalize them by using the awk script getGroupedCounts.awk , then give them to the R script to have the stats ; it returns the ID, the log2FC of the medians, the pvalue, and the counts.
				
					
					echo -e "cat <(paste <(echo -e \"id\\\tlog2FCMedian\\\tpvalue\") <(echo -e \"${all_samples_cond1_name[*]}\"|sed 's/ /\\\t/g') <(echo -e \"${all_samples_cond2_name[*]}\"|sed 's/ /\\\t/g') ) <(zcat $matrix_file |awk -v all_samples_cond1_pos=$all_samples_cond1_pos -v all_samples_cond2_pos=$all_samples_cond2_pos -v all_norm_factors_cond1=$all_norm_factors_cond1 -v all_norm_factors_cond2=$all_norm_factors_cond2 -v pvalue_threshold=$pvalue_threshold -v CPX=$CPX -f $getGroupedCounts|$getZIW_rscript) |gzip -c >${output_dir}train${one_train_pos}_result.tsv.gz && echo -e \"\\\n\\\t-> check file ${output_dir}train${one_train_pos}_result.tsv.gz\\\n\"\n" >>${output_dir}parallel_commands.sh
					
							
				else
					
					echo -e "cat <(paste <(echo -e \"id\\\tlog2FCMedian\\\tpvalue\") <(echo -e \"${all_samples_cond1_name[*]}\"|sed 's/ /\\\t/g') <(echo -e \"${all_samples_cond2_name[*]}\"|sed 's/ /\\\t/g') ) <(awk -v all_samples_cond1_pos=$all_samples_cond1_pos -v all_samples_cond2_pos=$all_samples_cond2_pos -v all_norm_factors_cond1=$all_norm_factors_cond1 -v all_norm_factors_cond2=$all_norm_factors_cond2 -v pvalue_threshold=$pvalue_threshold -v CPX=$CPX -f $getGroupedCounts $matrix_file |$getZIW_rscript) |gzip -c >${output_dir}train${one_train_pos}_result.tsv.gz && echo -e \"\\\n\\\t-> check file ${output_dir}train${one_train_pos}_result.tsv.gz\\\n\"\n" >>${output_dir}parallel_commands.sh		
				
				
				fi
				
				#echo -e "\n\t-> check file ${output_dir}train${one_train_pos}_result.tsv.gz\n"
				
				
				echo -e "\n===========================\n"
		
		fi


done



#process the folds in parallel
parallel --tmpdir ${output_dir} -j $nb_process < ${output_dir}parallel_commands.sh


