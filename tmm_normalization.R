library(edgeR)
#setwd("/local/Cory/Alzheimers/synapse/sinai/")
countsexon="sinai_counts.txt"
countsnormalized="sinai_count_TMMnormalized_CPM.txt"
counts=as.matrix(read.table(countsexon,check.names = F, header = T))

dge=DGEList(as.numeric(counts))
y=calcNormFactors(dge)
countsnorm=cpm(y)
write.table(countsnorm,file = countsnormalized,row.names=T,col.names=T,quote=F,sep="\t")