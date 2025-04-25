#!/usr/bin/env Rscript

#https://stackoverflow.com/questions/9370609/piping-stdin-to-r

library(ZIR)

input<-file('stdin')

open(input)

# while(length(row <- readLines(input,n=1)) > 0) {
# 
#     xy_values<-row
#     
#     id<-unlist(strsplit(xy_values,"\\+"))[1]
#     
#     x_values<-unlist(strsplit(xy_values,"\\+"))[2]
#     
#     x_values<-as.numeric(unlist(strsplit(x_values,",")))
#     
#     y_values<-unlist(strsplit(xy_values,"\\+"))[3]
#     
#     y_values<-as.numeric(unlist(strsplit(y_values,",")))
#     
#     log2FCMedian<-log2((median(y_values)+1e-6)/(median(x_values)+1e-6))
#     
#     p_value<-ziw(x_values, y_values, perm = FALSE)$p.value
#     
#     #to have the statistic instead
#     #p_value<-ziw(x_values, y_values, perm = FALSE)$statistics
#     
#     pvalue_threshold<-unlist(strsplit(xy_values,"\\+"))[4]
#     
#     #cat("pval : ",p_value)
#     
#     #& abs(log2FCMedian) >log2(1.5)
#     if(!is.na(p_value) & p_value<=pvalue_threshold){
#     
#     #in the case it is the statistic, we want the value to be equal or higher
#     #if(!is.na(p_value) & p_value>=pvalue_threshold){
#       
#       write.table(data.frame(t(data.frame(c(id,log2FCMedian,p_value,x_values,y_values)))),sep="\t",row.names=F, col.names=F, quote=F)
# 
#     }
# 
# }


while(length(row <- readLines(input,n=1)) > 0) {
  
  
  split_values<-unlist(strsplit(row,"\\+"))
  
  id<-split_values[1]
  
  x_values<-split_values[2]
  
  y_values<-split_values[3]
  
  pvalue_threshold<-split_values[4]
  
  x_values<-as.numeric(unlist(strsplit(x_values,",")))
  
  y_values<-as.numeric(unlist(strsplit(y_values,",")))
  
  log2FCMedian<-log2((median(y_values)+1e-6)/(median(x_values)+1e-6))
  
  p_value<-ziw(x_values, y_values, perm = FALSE)$p.value
  
  #to have the statistic instead
  #p_value<-ziw(x_values, y_values, perm = FALSE)$statistics
  
  #!is.na(p_value)
  #if(p_value<=pvalue_threshold){
  if(!is.na(p_value) & p_value<=pvalue_threshold){
    
    #in the case it is the statistic, we want the value to be equal or higher
    #if(!is.na(p_value) & p_value>=pvalue_threshold){
    
    write.table(data.frame(t(data.frame(c(id,log2FCMedian,p_value,x_values,y_values)))),sep="\t",row.names=F, col.names=F, quote=F)
    
  }
  
}

