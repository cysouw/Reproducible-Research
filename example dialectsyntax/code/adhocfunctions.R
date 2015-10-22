# plot a single column of data

single <- function(column, alldata = data, whites = sep, tess = v) {
	
	tmp <- table(alldata[,column])
	feature <- c("lightgrey", rainbow(length(tmp)-1))
	names(feature) <- names(tmp)
	cols <- c( feature[as.character(alldata[,column])], rep("white", nrow(whites)) )

	vmap(tess, col = cols, border = NA, outer =  NA) 
	legend("right", fill = feature, legend = names(feature), cex = 0.5)
	title(main = colnames(alldata)[column])
	
}