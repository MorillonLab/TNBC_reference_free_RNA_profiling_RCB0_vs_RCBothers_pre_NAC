#!/bin/bash

getTotCountsPerSamples="/home/marcgabriel/Desktop/scripts/getTotCountsPerSamples.sh"

zindex="/home/marcgabriel/Downloads/zindex/build/Release/zindex"


#in percent : 2/3 is 66%
#wanted_train=66
wanted_train=60

#nb samples with rec_abundance counts
rec_in_sample=5

#abundance in samples
rec_abundance=10

cond1="RCB0"

cond2="RCBothers"

#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers_proper_end_1kkk.tsv.gz"
#matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers_proper_end.tsv.gz"
#matrix_file="/media/marcgabriel/saylar9/Nouritza_DESeq2_batch123_without_10BadSamples_batchesInfoIncluded_22_02_2023/DESeq_norm_curie_canada_RCB0_vs_RCBothers/raw_counts_matrix.tsv"
#matrix_file="/media/marcgabriel/saylar9/Nouritza_DESeq2_batch123_without_10BadSamples_batchesInfoIncluded_22_02_2023/DESeq_norm_curie_canada_RCB0_vs_RCBothers/tnbc_reclassified_gene_counts_01_05_2024.tsv.gz"

matrix_file="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_RCB0_vs_RCBothers/reclassified_TNBC_01_05_2024/Curie_and_canada_design_36RCB0_vs_42RCBothers_reclassified_01_05_2024.tsv.gz"

#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_genes/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmerCounts_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_kmers/"

#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes_test2/"
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes_test3/"

#this one is ok 0.0067 RCB0 vs RCBothers (curie) / 0.0071 RCB0 vs RCBothers train ; 0.033 RCB0 vs RCBothers  test
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes_test4/"


#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes_test5/"

#this one is ok 0.013 RCB0 vs RCBothers train ; 0.024 RCB0 vs RCBothers  test
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes_test6/"

#this one is ok 0.0051 RCB0 vs RCBothers train ; 0.039 RCB0 vs RCBothers  test
#output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_genes_test7/"

output_dir="/media/marcgabriel/saylar6/Nouritza_kmercounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_${wanted_train}_kmers_test7/"

suffix="kmers"
#suffix="genes"


output_dir="${output_dir}/"
output_dir=$(echo $output_dir |sed 's/\/\//\//g')
if [ ! -d $output_dir ]; then mkdir -p $output_dir; fi 


########## cond1 #######


#shuffle cond1 sample names
if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

	shuffled_cond1=($(zcat $matrix_file|head -n1|cut -f2-|sed 's/\t/\n/g'|grep -E "${cond1}_[0-9]+$"|shuf))

else

	shuffled_cond1=($(head $matrix_file -n1|cut -f2-|sed 's/\t/\n/g'|grep -E "${cond1}_[0-9]+$"|shuf))

fi

#compute tot samples for cond1
total_cond1=$(echo -e ${#shuffled_cond1[*]})

#find how many samples to extract from cond1 to respect wanted_train
kept_train_cond1_nb=$(awk -v wanted_train=$wanted_train -v total_cond1=$total_cond1 'BEGIN{printf("%.0f\n", (wanted_train/100)*total_cond1)}')


kept_test_cond1_nb=$(awk -v total_cond1=$total_cond1 -v kept_train_cond1_nb=$kept_train_cond1_nb 'BEGIN{print total_cond1-kept_train_cond1_nb}')

echo -e "total cond1 : $total_cond1 ; kept train cond1 : $kept_train_cond1_nb ; kept test cond1 : $kept_test_cond1_nb\n"


if [[ ! -f ${output_dir}train_test_cond1_cond2.txt ]] || [[ $(wc -l ${output_dir}train_test_cond1_cond2.txt|awk '{print $1}') -ne 4 ]];then



	echo -e "${output_dir}train_test_cond1_cond2.txt doesn't exist, perfect, we're going to create it !\n\n"


	all_samples_cond1_train=($(echo -e ${shuffled_cond1[*]}|sed -E 's/ /\n/g'|head -n ${kept_train_cond1_nb}))

	all_samples_cond1_test=($(echo -e ${shuffled_cond1[*]}|sed -E 's/ /\n/g'|tail -n ${kept_test_cond1_nb}))
	
	echo -e "cond1\ttrain\t$(echo -e ${all_samples_cond1_train[*]}|sed -e 's/ /\t/g')" >${output_dir}train_test_cond1_cond2.txt
	
	echo -e "cond1\ttest\t$(echo -e ${all_samples_cond1_test[*]}|sed -e 's/ /\t/g')" >>${output_dir}train_test_cond1_cond2.txt


else

   echo -e "${output_dir}train_test_cond1_cond2.txt already exists, we are going to use it, otherwise, delete it !\n\n"
   
	all_samples_cond1_train=($(grep -P "cond1\ttrain" ${output_dir}train_test_cond1_cond2.txt|cut -f3-))

	all_samples_cond1_test=($(grep -P "cond1\ttest" ${output_dir}train_test_cond1_cond2.txt|cut -f3-))

fi


all_samples_cond1_train_pos=()


for one_sample in ${all_samples_cond1_train[*]};do

		#check if it's gzip matrix, then take the pos of the sample in the header of the matrix
		if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

			all_samples_cond1_train_pos+=($(zcat $matrix_file |head -n1|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		
		else
		
			all_samples_cond1_train_pos+=($(head -n1 $matrix_file|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		fi
		
		

 done
 
 
 
 all_samples_cond1_test_pos=()
 
 
 for one_sample in ${all_samples_cond1_test[*]};do

		#check if it's gzip matrix, then take the pos of the sample in the header of the matrix
		if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

			all_samples_cond1_test_pos+=($(zcat $matrix_file |head -n1|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		
		else
		
			all_samples_cond1_test_pos+=($(head -n1 $matrix_file|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		fi
		
		

 done
 
 
########## cond2 #######

 
 
#shuffle cond2 sample names

if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

	shuffled_cond2=($(zcat $matrix_file|head -n1|cut -f2-|sed 's/\t/\n/g'|grep -E "${cond2}_[0-9]+$"|shuf))

else

	shuffled_cond2=($(head $matrix_file -n1|cut -f2-|sed 's/\t/\n/g'|grep -E "${cond2}_[0-9]+$"|shuf))

fi

#compute tot samples for cond2
total_cond2=$(echo -e ${#shuffled_cond2[*]})

#find how many samples to extract from cond2 to respect wanted_train
kept_train_cond2_nb=$(awk -v wanted_train=$wanted_train -v total_cond2=$total_cond2 'BEGIN{printf("%.0f\n", (wanted_train/100)*total_cond2)}')

#finish the script
kept_test_cond2_nb=$(awk -v total_cond2=$total_cond2 -v kept_train_cond2_nb=$kept_train_cond2_nb 'BEGIN{print total_cond2-kept_train_cond2_nb}')

echo -e "total cond2 : $total_cond2 ; kept train cond2 : $kept_train_cond2_nb ; kept test cond2 : $kept_test_cond2_nb\n"

if [[ ! -f ${output_dir}train_test_cond1_cond2.txt ]] || [[ $(wc -l ${output_dir}train_test_cond1_cond2.txt|awk '{print $1}') -ne 4 ]];then



	echo -e "${output_dir}train_test_cond1_cond2.txt doesn't exist, perfect, we're going to create it !\n\n"


	all_samples_cond2_train=($(echo -e ${shuffled_cond2[*]}|sed -E 's/ /\n/g'|head -n ${kept_train_cond2_nb}))

	all_samples_cond2_test=($(echo -e ${shuffled_cond2[*]}|sed -E 's/ /\n/g'|tail -n ${kept_test_cond2_nb}))
	
	echo -e "cond2\ttrain\t$(echo -e ${all_samples_cond2_train[*]}|sed -e 's/ /\t/g')" >>${output_dir}train_test_cond1_cond2.txt
	
	echo -e "cond2\ttest\t$(echo -e ${all_samples_cond2_test[*]}|sed -e 's/ /\t/g')" >>${output_dir}train_test_cond1_cond2.txt


else

   echo -e "${output_dir}train_test_cond1_cond2.txt already exists, we are going to use it, otherwise, delete it !\n\n"
   
	all_samples_cond2_train=($(grep -P "cond2\ttrain" ${output_dir}train_test_cond1_cond2.txt|cut -f3-))

	all_samples_cond2_test=($(grep -P "cond2\ttest" ${output_dir}train_test_cond1_cond2.txt|cut -f3-))

fi

all_samples_cond2_train_pos=()


for one_sample in ${all_samples_cond2_train[*]};do

		#check if it's gzip matrix, then take the pos of the sample in the header of the matrix
		if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

			all_samples_cond2_train_pos+=($(zcat $matrix_file |head -n1|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		
		else
		
			all_samples_cond2_train_pos+=($(head -n1 $matrix_file|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		fi
		
		

 done
 
 
 
 all_samples_cond2_test_pos=()
 
 
 for one_sample in ${all_samples_cond2_test[*]};do

		#check if it's gzip matrix, then take the pos of the sample in the header of the matrix
		if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

			all_samples_cond2_test_pos+=($(zcat $matrix_file |head -n1|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		
		else
		
			all_samples_cond2_test_pos+=($(head -n1 $matrix_file|sed 's/\t/\n/g'|grep -n -P "${one_sample}$"|sed 's/\:/\n/g'|head -n1))
		
		fi
		
		

 done
 
 
if [[ ! -f ${output_dir}train_design.tsv ]] || [[ $(wc -l ${output_dir}train_design.tsv|awk '{print $1}') -eq 0 ]];then
 
 cat <(grep -P "cond1\ttrain" ${output_dir}train_test_cond1_cond2.txt|cut -f3-|sed 's/\t/\n/g'|awk -v cond1=$cond1 'OFS="\t"{print $1,cond1}') <(grep -P "cond2\ttrain" ${output_dir}train_test_cond1_cond2.txt|cut -f3-|sed 's/\t/\n/g'|awk -v cond2=$cond2 'OFS="\t"{print $1,cond2}') >${output_dir}train_design.tsv
 
fi


 
both_pos_train=$(paste -d',' <(echo -e "${all_samples_cond1_train_pos[*]}"|sed 's/ /,/g') <(echo -e "${all_samples_cond2_train_pos[*]}"|sed 's/ /,/g'))
 
both_pos_test=$(paste -d',' <(echo -e "${all_samples_cond1_test_pos[*]}"|sed 's/ /,/g') <(echo -e "${all_samples_cond2_test_pos[*]}"|sed 's/ /,/g'))


############ for train  ###########

if [[ ! -f ${output_dir}${suffix}_train_counts_matrix.tsv.gz ]];then

if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

	zcat $matrix_file|awk -v both_pos_train=$both_pos_train 'OFS="\t"{full_line=$1;split(both_pos_train,a,",");for(i=1;i<=length(a);i++){full_line=full_line"\t"$(a[i])};print full_line}'|gzip -c >${output_dir}${suffix}_train_counts_matrix.tsv.gz


else

	awk -v both_pos_train=$both_pos_train 'OFS="\t"{full_line=$1;split(both_pos_train,a,",");for(i=1;i<=length(a);i++){full_line=full_line"\t"$(a[i])};print full_line}' $matrix_file|gzip -c >${output_dir}${suffix}_train_counts_matrix.tsv.gz


fi

fi

if [[ ! -f ${output_dir}${suffix}_train_counts_matrix_${rec_abundance}countsinAtLeast${rec_in_sample}samples.tsv.gz ]];then

	zcat ${output_dir}${suffix}_train_counts_matrix.tsv.gz|awk -v rec_in_sample=$rec_in_sample -v rec_abundance=$rec_abundance 'OFS="\t"{if(NR>1){tot=0;for(i=2;i<=NF;i++){if($i>=rec_abundance){tot=tot+1}};if(tot>=rec_in_sample){print}}else{print}}' |gzip -c >${output_dir}${suffix}_train_counts_matrix_${rec_abundance}countsinAtLeast${rec_in_sample}samples.tsv.gz

fi

if [[ ! -f ${output_dir}tot_${suffix}_${rec_abundance}countsinAtLeast${rec_in_sample}samples.tsv ]];then

$getTotCountsPerSamples ${output_dir}${suffix}_train_counts_matrix_${rec_abundance}countsinAtLeast${rec_in_sample}samples.tsv.gz >${output_dir}tot_${suffix}_${rec_abundance}countsinAtLeast${rec_in_sample}samples.tsv

fi


############ for test ###########



if [[ ! -f ${output_dir}${suffix}_test_counts_matrix.tsv.gz ]];then

	if [[ $(echo -e $matrix_file|grep -E "\.gz$") ]];then

		zcat $matrix_file|awk -v both_pos_test=$both_pos_test 'OFS="\t"{full_line=$1;split(both_pos_test,a,",");for(i=1;i<=length(a);i++){full_line=full_line"\t"$(a[i])};print full_line}'|gzip -c >${output_dir}${suffix}_test_counts_matrix.tsv.gz


	else

		awk -v both_pos_test=$both_pos_test 'OFS="\t"{full_line=$1;split(both_pos_test,a,",");for(i=1;i<=length(a);i++){full_line=full_line"\t"$(a[i])};print full_line}' $matrix_file|gzip -c >${output_dir}${suffix}_test_counts_matrix.tsv.gz


	fi

fi

if [[ ! -f ${output_dir}${suffix}_test_counts_matrix_CPM_norm.tsv.gz ]];then


    if [[ ! -f ${output_dir}tot_${suffix}_test.tsv ]];then

		$getTotCountsPerSamples ${output_dir}${suffix}_test_counts_matrix.tsv.gz >${output_dir}tot_${suffix}_test.tsv
	
	fi


	tot_counts_test=$(cut -f2 ${output_dir}tot_${suffix}_test.tsv|tr '\n' ','|sed 's/,$//g')

	echo -e "\ntest counts : $tot_counts_test\n\n"

	zcat ${output_dir}${suffix}_test_counts_matrix.tsv.gz |awk -v tot_counts_test=$tot_counts_test 'OFS="\t"{if(NR>1){full_line=$1;split(tot_counts_test,a,",");for(i=1;i<=length(a);i++){full_line=full_line"\t"($(i+1)/a[i])*1000000};print full_line}else{print}}' |gzip -c >${output_dir}${suffix}_test_counts_matrix_CPM_norm.tsv.gz

fi

if [[ ! -f ${output_dir}${suffix}_test_counts_matrix_CPM_norm.tsv.gz.zindex ]];then

	echo -e "\n- let's create the zindex\n\n"

	$zindex ${output_dir}${suffix}_test_counts_matrix_CPM_norm.tsv.gz --tab-delimiter --field 1 --unique
	

fi




echo -e "\n-> check file : ${output_dir}train_test_cond1_cond2.txt & ${output_dir}train_design.tsv & ${output_dir}${suffix}_train_counts_matrix.tsv.gz & ${output_dir}${suffix}_train_counts_matrix_${rec_abundance}countsinAtLeast${rec_in_sample}samples.tsv.gz & ${output_dir}tot_${suffix}_10countsinAtLeast5samples.tsv & ${output_dir}${suffix}_test_counts_matrix_CPM_norm.tsv.gz\n"





 

