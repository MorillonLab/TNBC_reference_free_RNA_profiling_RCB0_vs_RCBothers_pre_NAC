#!/usr/bin/awk -f

BEGIN{
	
	#split values according to comma ; counts position of cond1 samples
	split(all_samples_cond1_pos,cond1_counts_pos,",");
	
	#split values according to comma ; counts position of cond2 samples
	split(all_samples_cond2_pos,cond2_counts_pos,",");
	
	#split values according to comma ; norm factors of cond1 samples
	split(all_norm_factors_cond1,all_norm_factors_cond1_val,",");
	
	#split values according to comma ; norm factors of cond2 samples
	split(all_norm_factors_cond2,all_norm_factors_cond2_val,",");
	
	
	

}

{
	
	
	if(NR>1){
		
		    #initialize the final variable that will contain the counts, with the ID (use as separator "+")
			obtained_both_counts=$1"+";
			
			#for each sample of cond1 take the count (thanks to its position), normalize it, then store it in the final variable (separate the values by comma)
			for(pos1=1;pos1<=length(cond1_counts_pos);pos1++){
				
				if(pos1==1){
					
					obtained_both_counts=obtained_both_counts ($cond1_counts_pos[pos1]/all_norm_factors_cond1_val[pos1])*CPX;
					
				}else{
					
					obtained_both_counts=obtained_both_counts","$cond1_counts_pos[pos1]/all_norm_factors_cond1_val[pos1]*CPX;
					
				}
				
			}
			
			#for each sample of cond2 take the count (thanks to its position), normalize it, then store it in the final variable (separate the values by comma)
			#separate those new values and values of cond1 with "+"
			for(pos2=1;pos2<=length(cond2_counts_pos);pos2++){
				
					
					if(pos2==1){
						
						#separate the cond1 counts and cond2 counts with "+"
						obtained_both_counts=obtained_both_counts"+"($cond2_counts_pos[pos2]/all_norm_factors_cond2_val[pos2])*CPX;
						
					}else{
							
							
							
							obtained_both_counts=obtained_both_counts","($cond2_counts_pos[pos2]/all_norm_factors_cond2_val[pos2])*CPX;
							
					}
					
			}
					
			#print the results (it is in this form : ID+cond1_value1,cond1_value2,...+cond2_value1,cond2_value2,...) and the pvalue threshold (separated with "+")
			print obtained_both_counts"+"pvalue_threshold;
		
		
	}
	
}
