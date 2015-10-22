#' ---
#' title: "Visualisation of Multialignments"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("manual.R")

# Depends on the following packages from CRAN
library(showtext) # for special fonts
library(qlcData) # for reading MSA-files
library(qlcVisualize) # for drawing correspondence sets
library(qlcMatrix) # for computing similarities
library(apcluster) # for partitioning

# Load all data, using qlcData
files <- list.files("sources/msa", full.names = TRUE)
all <- sapply(files, qlcData::read.align, flavor = "BDPA", simplify = FALSE)

# which different datasets are included?
datasets <- sapply(all, function(x){x$meta$dataset})
table(datasets)

# select one group
group <- "Bai"
selection <- all[datasets == group]
alignments <- qlcData::join.align(selection)

# compute similarity between correspondences, use qlcMatrix
# ignore gaps for similarity
tmp <- t(alignments)
tmp[tmp == "-"] <- NA
tmp[tmp == "_"] <- NA # only for Dutch
sim <- qlcMatrix::sim.obs(tmp)

# remove columns with too many NA or gaps
nas <- apply(tmp,1,function(x){sum(is.na(x))}) < 10
sim <- sim[nas,nas]
alignments <- alignments[,nas]

# make clusters of alignments
# apcluster is often a bit splitty, making too many clusters
clus <- apcluster::apcluster(sim)
clus <- apcluster::labels(clus, "enum")
max(clus)

# complete clustering is easier to handle
clus <- cutree(hclust(as.dist(-sim)),h = -0.01)
max(clus)

# plot clusters using qlcVisualize
# values of 'cex' parameters might needs tweaking depending on size of graphs
# also note that the font setting might not work, then choose another font
# note that this might lead to warnings and strang output because the font might not have the desired glyphs

plotCluster <- function(cluster) {
	
	
	# PDF device
	filename <- paste0("images/", group, "/" , cluster, ".pdf")
	dev.new(file = filename 
			, width = nrow(alignments)/6+1
			, height = max(table(clus))/6+1
			, type = "pdf"
			)
			
	sysfonts::font.add(family = "Charis SIL", regular = "CharisSIL-R.ttf")
	showtext::showtext.begin()

	# plotting the image
	columns <- alignments[ , clus == cluster]				
	qlcVisualize::limage(columns
						, col = rainbow(8)
						, order = "R2E"
						, method = "poi"
						, show.remaining = TRUE
						, cex.axis = .5
						, cex.remaining = .5
						, cex.legend = .7
						, font = "Charis SIL"
						)
	
	showtext::showtext.end()
	dev.off()
}

# creat all Bai correspondence graphics
# can be found in the directory "images/Bai"
sapply(which(table(clus) > 1), plotCluster)

# show Session Info
sessionInfo()
