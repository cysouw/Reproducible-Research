#' ---
#' title: "Analysis of ValPal data"
#' author: "Michael Cysouw"
#' date: "30 September 2015"
#' ---

# make html-version of this manual with:
# rmarkdown::render("manual.R")

#+ fig.width = 7, fig.height = 7

# depends on the following packages from CRAN
library(qlcVisualize)
library(qlcMatrix)

# load ad-hoc functions
source("code/adhocfunctions.R")

# read data, selecting only basic coding frames
data <- read.valpal("data")

# distances between microroles ignoring frequencies below 5 languages
# for distances, separate coding into parts
# returns a distance and a new data matrix!
d <- role.dist(data, ignore = 5, separate = TRUE)

# multidimensional scaling
p <- cmdscale(d$dist)

# ad-hoc condensing of dimension 1 for nicer display
p[,1] <- abs(p[,1])^2 * sign(p[,1])

# show roles
plot(p, type = "n", axes =  FALSE, xlab = "", ylab = "")
text(p, labels = rownames(d$dist), cex = 0.5)

# semantic map, based internally on lmap() from qlcVisualize
# setting parameters to get suitable visualization

tmp <- function(x) {
		semantic.map(p, x, d$data
					, draw = 5
					, levels = 0.2
					, cex = 0.7
					, density = 0.1
					, box = 0.2
					, position = "topright"
					, font = "CharisSIL"
					, note = FALSE
					, cex.legend = 0.7
					, tightness = 0.01
					) }

tmp("Chintang")
tmp("Bezhta")
tmp("Nen")
tmp("Yupik")
tmp("Hooc")
tmp("Jaminjung")

# Show session Info
sessionInfo()
