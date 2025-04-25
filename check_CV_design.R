#!/usr/bin/env Rscript

library(ComplexHeatmap)
library(circlize)
library(gridExtra)
library(grid)

args <- commandArgs(TRUE)

home<-args[1]

all_tables<-args[2]

both_conds_prefix<-args[3]

suffix<-args[4]


setwd(home)

both_conds_prefix<-unlist(strsplit(both_conds_prefix,","))

cat(both_conds_prefix)

all_tables<-unlist(strsplit(all_tables,","))


plot_name<-paste(home,"heatmap_CV_design_",suffix,".pdf",sep="")

all_grobs<-list()

for(one_pos in 1:length(all_tables)){
  

        my_table<-all_tables[one_pos]
        
        my_dataframe<-read.delim(my_table,header=T)
        
        my_matrix<-data.matrix(data.frame(my_dataframe[which(grepl(paste("^",both_conds_prefix[1],"_",sep=""),names(my_dataframe))==T | grepl(paste("^",both_conds_prefix[2],"_",sep=""),names(my_dataframe))==T)], row.names=my_dataframe$folds))
        
        
        #range according to the quantiles ; we will map the colors on them
        my_range<-c(quantile(my_matrix,0),quantile(my_matrix,0.05),quantile(my_matrix,0.10),
                    quantile(my_matrix,0.15),quantile(my_matrix,0.20),quantile(my_matrix,0.25),
                    quantile(my_matrix,0.30),quantile(my_matrix,0.35),quantile(my_matrix,0.40),
                    quantile(my_matrix,0.45),quantile(my_matrix,0.50),quantile(my_matrix,0.55),
                    quantile(my_matrix,0.60),quantile(my_matrix,0.65),quantile(my_matrix,0.70),
                    quantile(my_matrix,0.75),quantile(my_matrix,0.80),quantile(my_matrix,0.85),
                    quantile(my_matrix,0.90),quantile(my_matrix,0.95),quantile(my_matrix,1))
        
        
        #interpolate the colors according to "my_range" and the associated colors
        #the number given to G_colfunc() should be equal to the length of "my_range"
        my_palette = colorRamp2(c(0,1),
                                c("white","cornflowerblue"))
        
        
        both_conds2<-c("#5F9EA0","deeppink3")
        
        names(both_conds2)<-both_conds_prefix
        
        
        hb<-HeatmapAnnotation(df =data.frame(condition = gsub("_[0-9]+$","",colnames(my_matrix)),check.names=F),                  
                              col =list(condition=both_conds2),
                              annotation_legend_param=list(labels_gp = gpar(fontsize = 16),title_gp = gpar(fontsize = 16),grid_width= unit(12, "mm"),nrow = 1, by_row = F,border = "black"),show_annotation_name=F,which="column",show_legend =F)
        
        
        
        ## non-fixed columns (samples), fixed rows (ordered by best padj) ##
        hm<-Heatmap(my_matrix,
                    name = "training",
                    #name = "log10(normalized counts+1)",
                    col = my_palette,#clustering_distance_rows = "euclidean",
                    show_row_names=T,
                    show_heatmap_legend = F,
                    show_column_names = T,
                    cluster_columns =F,
                    cluster_rows =F,
                    row_names_side="right",
                    row_title_side="left",
                    clustering_method_columns = "ward.D2",
                    column_title=paste(ncol(my_matrix)," samples\n",both_conds_prefix[1]," : ",length(grep(paste("^",both_conds_prefix[1],"_",sep=""),names(my_dataframe),value=T))," ; ",both_conds_prefix[2]," : ",length(grep(paste("^",both_conds_prefix[2],"_",sep=""),names(my_dataframe),value=T)),sep=""),
                    row_title=paste(nrow(my_matrix)," ","Folds",sep=""),
                    use_raster = F,
                    row_names_gp = gpar(fontsize = 16),
                    heatmap_legend_param=list(labels_gp=gpar(fontsize=16),title_gp=gpar(fontsize = 16),grid_width= unit(8, "mm"),grid_height= unit(8, "mm"),legend_direction = "vertical"),bottom_annotation = c(hb))
        lgd = Legend(labels = c("left_out_block","traing_set",names(both_conds2)),legend_gp = gpar(fill = c("white","cornflowerblue",both_conds2)), nrow = 1,border="black",grid_width= unit(12, "mm"),grid_height= unit(5, "mm"),direction = c("horizontal"),title ="cross validation set",labels_gp = gpar(fontsize = 16),title_gap = unit(2, "mm"),title_gp = gpar(fontsize = 16, fontface = "plain"))
        
        hm_list<-hm
        
        #https://github.com/jokergoo/ComplexHeatmap/issues/110
        
        my_grob<-grid.grabExpr({
          
            
                draw(hm_list,show_heatmap_legend = F,annotation_legend_side = "bottom")
            
                
                decorate_heatmap_body("training", {
                  
                  grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 1))
                  
                })
                
                for(one_col in 1:ncol((my_matrix))){
                  
                  #paste("log10(",norm_prefix,"+1)",sep="")
                  decorate_heatmap_body("training", {
                    i = which(colnames(my_matrix) == colnames(my_matrix)[one_col])
                    x = i/ncol(my_matrix)
                    grid.lines(c(x, x), c(0, 1), gp = gpar(lwd = 1))
                  })
                  
                }
                
              
              for(one_row in 1:nrow((my_matrix))){
                
                decorate_heatmap_body("training", {
                  i = one_row
                  x = i/nrow(my_matrix)
                  grid.lines( c(0, 1),c(x, x), gp = gpar(lwd = 1))
                })
                
              }
                
                decorate_heatmap_body("training", {
                  i = which(colnames(my_matrix) ==grep(paste("^",both_conds_prefix[1],"_",sep=""),names(my_dataframe),value=T)[length(grep(paste("^",both_conds_prefix[1],"_",sep=""),names(my_dataframe),value=T))])
                 
                  x = i/ncol(my_matrix)
                  grid.lines(c(x, x), c(0, 1), gp = gpar(lwd = 8,col="orange"))
                })
                
        })
        
        all_grobs[[length(all_grobs)+1]]<-my_grob
        
        if(one_pos==length(all_tables)){
        
          lgd<-grid.grabExpr({draw(lgd )})
          
          all_grobs[[length(all_grobs)+1]]<-lgd
          
        }
            
}

if(length(all_grobs)>1){

  pdf(file=paste(plot_name,sep=""),width=30,height=15)
  
    grid.arrange(grobs = all_grobs,ncol=2)
  
  dev.off()

}else{
  
  pdf(file=paste(plot_name,sep=""),width=30,height=15)
  
    grid.draw(all_grobs[[1]])
  
  dev.off()
}

cat("\ncheck file : ",plot_name,"\n")

