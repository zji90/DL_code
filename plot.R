library(ggplot2)
load("res.rda")
allres <- allres[allres$dr != 0.25 & allres$layernum <= 3 & allres$lr == 0.1,]
pdf("Results.pdf")
ggplot(data.frame(AUC=allres[,"auc"],Dropout=paste0("Dropout ",allres[,"dr"]),Layer=allres[,"layernum"],Nodenum=allres[,"nodenum"],Activate=ifelse(allres[,"accfun"]==1,"Softmax","RMSE")),aes(Layer,Nodenum)) + geom_tile(aes(fill = AUC), colour = "white") + scale_fill_gradient(low = "white",high = "steelblue") + facet_wrap(Activate~Dropout) + theme_bw()
dev.off()
