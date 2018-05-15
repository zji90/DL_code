library(PRROC)
library(mxnet)
load("data.rda")
allres <- NULL
for (dr in c(0,0.25,0.5)) {
      for (lr in c(0.1,1)) {
            for (layernum in 1:5) {
                  for (nodenum in c(10,50)) {
                        model = mx.mlp(trainX, trainY, hidden_node = rep(nodenum,layernum), out_node = 2, dropout = dr, out_activation = "softmax", learning.rate = lr)
                        preds = predict(model, testX)
                        auc <- pr.curve(scores.class0 = preds[2,], weights.class0 = testY)$auc.davis.goadrich      
                        allres <- rbind(allres,data.frame(auc=auc,dr=dr,lr=lr,layernum=layernum,nodenum=nodenum,accfun=1))
                        
                        model = mx.mlp(trainX, trainY, hidden_node = rep(nodenum,layernum), out_node = 1, dropout = dr, out_activation = "rmse", learning.rate = lr)
                        preds = predict(model, testX)
                        auc <- pr.curve(scores.class0 = preds[1,], weights.class0 = testY)$auc.davis.goadrich      
                        allres <- rbind(allres,data.frame(auc=auc,dr=dr,lr=lr,layernum=layernum,nodenum=nodenum,accfun=2))
                  }
            }
      }
}
save(allres,file="res.rda")
