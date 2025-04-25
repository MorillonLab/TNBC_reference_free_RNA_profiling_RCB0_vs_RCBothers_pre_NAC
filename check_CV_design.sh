#!/bin/bash

######## input variables ########

input_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/CV_design_dir/"

output_dir="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/CV_design_dir/"

design="/media/marcgabriel/saylar6/Nouritza_genecounts_01_05_2024_Curie_and_canada_design_randomizedAndSplitInTrainAndTest_wanted_train_60_genes_test7/train_design.tsv"

getTransposedLines="/home/marcgabriel/Desktop/scripts/getTransposedLines.awk"

check_CV_design_Rscript="/home/marcgabriel/Desktop/scripts/check_CV_design.R"

output_dir="${output_dir}/"
output_dir=$(echo $output_dir |sed 's/\/\//\//g')
if [ ! -d $output_dir ]; then mkdir -p $output_dir; fi 

repeat_num=5

series=($(seq 0 $(($repeat_num-1)) ))

exp_name="5folds_5timesRepeated_CV"

#########################################


all_transposed_matrix=()


for one_repeat in ${series[*]};do

        true_rep=$((one_repeat + 1))


		test_files=$(find $input_dir -name "*test*"|grep -E "test${one_repeat}_"|sort -V)
		
		
		i=0

		all_tables=()

		all_names=()

		sort_command=""


		for one_file in $test_files;do

			my_rows=$(while read line;do id=$(echo -e "${line}"|cut -f1);grep -P -n "${id}\t" $design ;done < $one_file|awk -F':' '{print $1}'|tr '\n' ','|sed 's/,$//g'|awk '{print}')
				
			awk -v my_rows=$my_rows 'OFS="\t"{split(my_rows,a,",");score=1;for(i=1;i<=length(a);i++){if(NR==a[i]){score=0}};print $1,score}' $design >${output_dir}tmp_${i}.tsv
			
			all_tables+=(${output_dir}tmp_${i}.tsv)
			

			i=$((i+1))
			
			
			
			all_names+=("fold_${i}")
			
			if [[ $i -eq 1 ]];then
			
				sort_command="-k$((i+2)),$((i+2))n"
			
			
			else
				sort_command="${sort_command} -k$((i+2)),$((i+2))n"   
			
			fi

		done


		ulimit -Sn 10240 

		cond1=$(cut -f2 $design|uniq -c|awk '{print $2}'|head -n1)

		cond2=$(cut -f2 $design|grep -v -P "${cond1}$"|uniq -c|awk '{print $2}'|tail -n1)


		cat <(paste <(echo -e "samples\tcondition") <(echo -e "${all_names[*]}"|sed -E 's/ /\t/g')) <(cat <(paste ${all_tables[*]}| awk '{all=$1;for(i=2;i<=NF;i++){if(i%2==0){all=all"\t"$i}};print all}'|awk '{all=$1;cond=gensub(/_[0-9]+$/,"","g",$1);all=all"\t"cond;for(i=2;i<=NF;i++){all=all"\t"$i};print all}'|sort -k2,2V $sort_command|grep -P "${cond1}\t") <(paste ${all_tables[*]}| awk '{all=$1;for(i=2;i<=NF;i++){if(i%2==0){all=all"\t"$i}};print all}'|awk '{all=$1;cond=gensub(/_[0-9]+$/,"","g",$1);all=all"\t"cond;for(i=2;i<=NF;i++){all=all"\t"$i};print all}'|sort -k2,2V $sort_command|grep -P "${cond2}\t")) >${output_dir}matrix_of_CV_rep_${true_rep}.tsv

		awk -f $getTransposedLines ${output_dir}matrix_of_CV_rep_${true_rep}.tsv |awk 'NR!=2{OFS="\t";if(NR==1){$1="folds"};print}' >${output_dir}matrix_of_CV_transposed_rep_${true_rep}.tsv

		for F in ${all_tables[*]};do rm $F;done

		echo -e "\n-> check file : ${output_dir}matrix_of_CV_rep_${true_rep}.tsv && ${output_dir}matrix_of_CV_transposed_rep_${true_rep}.tsv\n"

		both_conds="${cond1},${cond2}"
		
		all_transposed_matrix+=(${output_dir}matrix_of_CV_transposed_rep_${true_rep}.tsv)

		
done

all_transposed_matrix=$(echo -e ${all_transposed_matrix[*]}|sed 's/ /,/g')


set -x
$check_CV_design_Rscript ${output_dir} $all_transposed_matrix $both_conds $exp_name




