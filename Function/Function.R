RFS = "Disease free surival probability (%)"
OS = "Overall surival probability (%)"
####
F.plot_confusion <- function(data,xlab,ylab,title_text){ 
  ggplot(data = data, aes(x = Var1,
                          y = factor(Var2,levels = sort(levels(Var2),decreasing = T)),
                          fill = Freq)) +
    geom_tile(color = "white", size = 2) +
    geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1,family = "TNR",size=6) +
    xlab(xlab) +
    ylab(ylab) +
    labs(title = title_text)+
    scale_fill_gradient(low = "skyblue",
                        high = "dodgerblue4") +
    theme(plot.background = element_blank(),
          panel.background = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "none") +
    theme(text = element_text(family = "TNR"),
          axis.text = element_text(color="black",size = 18),
          axis.text.x = element_text(vjust = 3),
          axis.text.y = element_text(hjust = 1.6),
          axis.title = element_text(size = 22),
          plot.title = element_text(size = 22,hjust = 0.5)
    )
}
#-----------------------------------------------------------------

####
windowsFonts(TNR=windowsFont("Times New Roman"))
F.plot_surival <- function(fit_object,surivaldata,ytitle,legend_text,palettes=c("green","blue","red")){
  p <- ggsurvplot(fit_object, data = surivaldata,
                  
                  #conf.int = TRUE,
                  risk.table = FALSE,
                  pval = TRUE,
                  #palette = c("#4169E1","#90EE90","#FF6347",'#A52A2A'),
                  palette = palettes,
                  legend="top",
                  #legend = c(0.8,0.9),
                  legend.title = "",
                  break.x.by = 10,
                  xlab = "Time after surgery (months) ",
                  ylab = ytitle,
                  title = "",
                  size = 1.2,
                  xlim = c(0,85),
                  censor.size = 6,
                  censor.shape3 =3 ,
                  surv.median.line = "none",
                  pval.size = 7,
                  ylim = c(0,1.15),
                  pval.coord = c(3,1.05),
                  
                  ggtheme = theme_bw() + 
                    theme(panel.background = element_rect("white"),
                          text = element_text(family = "TNR"),
                          axis.text = element_text(family = "TNR",size = 16,color = "black"),
                          #panel.grid = element_blank(),
                          axis.title.y = element_text(vjust = 2),
                          panel.border = element_blank(),
                          panel.grid = element_blank(),
                          axis.line = element_line(size = 1.3),
                          axis.ticks = element_line(size = 1.2),
                          axis.ticks.length = unit(0.2,"cm")),
                  
                  
  )
  
  
  
  
  p$plot$layers[[4]]$aes_params$family <- "TNR" 
  p <- p$plot + 
    scale_y_continuous(expand = c(0.0,0.0,0.018,0),) +
    scale_x_continuous(expand = c(0,0)) +
    theme(legend.text = element_text(size = 16),
          axis.title = element_text(size = 20)) +
    scale_color_manual(labels = legend_text,
                       values = palettes) 
  
  return(p)
  
  
}
#-----------------------------------------

F.clinico.anno <- function(sample.anno=NULL,sample.order=NULL,w=1,h=1,
                          anno=NULL){
  sample.anno$blank <- colnames(sample.anno)
  sample.anno$names <- factor(row.names(sample.anno),
                              levels = sample.order)
  p.group <- ggplot(sample.anno,aes(x=names,y=blank,fill=sample.anno[,1]))+
    geom_tile()
  p.group2 <- p.group+theme_minimal()+scale_y_discrete(position="right") +
    xlab(NULL) + ylab(NULL) + labs(fill=anno)+
    theme(axis.text.y = element_text(family = "TNR",colour = "black",size = 10),
          axis.text.x =element_blank(),
          panel.background = element_blank(),
          panel.grid = element_blank(),
          legend.text = element_text(family = "TNR",colour = "black",size=10),
          legend.title = element_text(family = "TNR",colour = "black",size=12))+
    scale_fill_manual(values = c("green","blue","red","red4"))+
    theme(plot.margin = unit(c(1/h,1/w,1/h,1/w),"lines"))+
    #theme(legend.direction = "horizontal")+
    scale_y_discrete(position = "right")
  return(p.group2)
}

#------------------------------------------------------
F.heatmap <- function(data=NULL,gene.order=NULL,sample.order=NULL,fillname){
  data$name <- row.names(data)
  p1 <- tidyr::gather(data, 1:(dim(data)[2]-1), key="condition", value='expr')
  #print(p1)
  p1$condition <- factor(p1$condition,levels=sample.order)
  p1$names <- factor(p1$name,levels = gene.order)
  p.heat <- ggplot(p1,aes(condition,names,fill=expr)) +
    geom_tile()+
    theme_bw()+
    scale_fill_gradientn(colours = colorRampPalette(c("forestgreen", "grey0", "red2"))(200))+
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank(),
          axis.ticks = element_blank())+
    labs(fill=fillname)
  return(p.heat)
  
}
#------------------------------------------------------
F.tree <- function(r.hclust,k=NULL){fviz_dend(r.hclust, k = k, 
                    color_labels_by_k = TRUE, 
                    show_labels = FALSE, labels_track_height = 0, 
                    horiz = TRUE,
                    lwd=0.6,ggtheme = theme_classic(),
                    k_colors = c("grey32","grey45","grey58"))+
  theme(title = element_blank(), 
        axis.text.x = element_blank(),
        axis.ticks = element_blank(), 
        axis.line.x = element_blank())
}
#--------------------------------------------------------
F.pasteHR <- function(conf.int){
  paste0(round(conf.int[1],2),"(",round(conf.int[3],2),"-",round(conf.int[4],2),")")
}
#--------------------------------------------------------
F.plot_confusion <- function(data,xlab,ylab,title_text,s=8){ 
  ggplot(data = data, aes(x = Var1,
                          y = factor(Var2,levels = sort(levels(Var2),decreasing = T)),
                          fill = Freq)) +
    geom_tile(color = "white", size = 2) +
    geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1,family = "TNR",size=s) +
    xlab(xlab) +
    ylab(ylab) +
    labs(title = title_text)+
    scale_fill_gradient(low = "skyblue",
                        high = "dodgerblue4") +
    theme(plot.background = element_blank(),
          panel.background = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "none") +
    theme(text = element_text(family = "TNR"),
          axis.text = element_text(color="black",size = 18),
          axis.text.x = element_text(vjust = 3),
          axis.text.y = element_text(hjust = 1.6),
          axis.title = element_text(size = 22),
          plot.title = element_text(size = 22,hjust = 0.5)
    )
}