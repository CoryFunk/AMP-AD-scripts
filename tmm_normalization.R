library(edgeR)
countsexon="read_counts.txt"
countsnormalized="read_count_TMMnormalized_CPM.txt"
counts=as.matrix(read.table(countsexon,check.names = F, header = T))

dge=DGEList(as.numeric(counts))
y=calcNormFactors(dge)
countsnorm=cpm(y)
write.table(countsnorm,file = countsnormalized,row.names=T,col.names=T,quote=F,sep="\t")
