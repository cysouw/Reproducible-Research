#' ---
#' title: "Syntactic analysis of Wenker data"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("manual.R")

# load necessary libraries 
library(qlcVisualize)
library(qlcMatrix)

# load data
loc <- read.delim("data/locations.txt", dec = ",", fill =  FALSE)
data <- read.delim("data/wenker.txt", fill = FALSE)

# similarities between dialects based on syntactic data
sim <- qlcMatrix::sim.obs(data, method = "weighted")

# to make voronoi diagram
# add manual separation of separate areas by adding white polygons
# I used locator() to determine these coordinates

sep <- cbind( Longitude = c(11.34162, 11.19866, 18.78059, 29.87453)
			, Latitude  = c(46.09955, 46.07597, 49.33322, 46.15076)
			)

# these three steps take some time, about 70 seconds
system.time({
	
	# determine window for the drawing
	window <- qlcVisualize::hullToOwin(rbind(loc[,2:3], sep), shift = 0.1, alpha = 0.3)
	
	# within the window, make a voronoi polygon division
	v <- qlcVisualize::voronoi(rbind(loc[,2:3], sep), window)
	
	# determine colors based on the "heeringa" approach
	cols <- c( qlcVisualize::heeringa(1-sim), rep("white", nrow(sep)) )

})

# global similarities between the dialects
vmap(v, col = cols, border = NA, outer.border =  NA) 
title(main = "Global syntactic similarity")

# Plot single features
# using ad-hoc function to select the data
source("code/adhocfunctions.R")

single(1)
single(15)

# show Session Info
sessionInfo()
