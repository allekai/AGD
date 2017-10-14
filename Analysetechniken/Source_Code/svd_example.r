library(gplots)
library(xtable)

cat('Reading file')
file <- read.csv(file="svd_example.csv")
svd <- svd(file)

xFile <- xtable(file)
print.xtable(xFile, type="latex", file="original_data.tex")

ddiag <- diag(svd$d)
xDdiag <- xtable(ddiag)
print.xtable(xDdiag, type="latex", file="svd_d.tex")

xU <- xtable(svd$u)
print.xtable(xU, type="latex", file="svd_u.tex")

xV <- xtable(t(svd$v))
print.xtable(xV, type="latex", file="svd_v.tex")

xMat <- xtable(file,align=rep("",ncol(file)+1))
print(xMat, type="latex", file="org_data_mat.tex", floating=FALSE, tabular.environment="bmatrix", hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

uMat <- xtable(svd$u,align=rep("",ncol(svd$u)+1))
print(uMat, type="latex", file="u_mat.tex", floating=FALSE, tabular.environment="bmatrix", hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)


vMat <- xtable(svd$v,align=rep("",ncol(svd$v)+1))
print(vMat, type="latex", file="v_mat.tex", floating=FALSE, tabular.environment="bmatrix", hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

dMat <- xtable(ddiag,align=rep("",ncol(ddiag)+1))
print(dMat, type="latex", file="d_mat.tex", floating=FALSE, tabular.environment="bmatrix", hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

d <- svd$d
d[3:6] <- 0

print(d)

pdf("original_data.pdf")
heatmap.2(data.matrix(file), trace='none', denscol='black', margins=c(6,8), srtCol=45)
dev.off()

d <- diag(d)

dMat <- xtable(d,align=rep("",ncol(d)+1))
print(dMat, type="latex", file="d_reduced_mat.tex", floating=FALSE, tabular.environment="bmatrix", hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)


reducedFile <- svd$u %*% d %*% t(svd$v)
names <- rownames(file)
movies <- colnames(file)

pdf("reduced_data.pdf")
heatmap.2(reducedFile, trace='none', denscol='black', margins=c(6,8), srtCol=45, labRow=names,labCol=movies, symbreaks=FALSE, symkey=FALSE)
dev.off()

redAMat <- xtable(reducedFile, align=rep("",ncol(reducedFile)+1))
print(dMat, type="latex", file="reduced_data_mat.tex", floating=FALSE, tabular.environment="bmatrix", hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)


