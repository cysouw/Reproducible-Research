read.valpal <- function(dir) {

	# selected files with basic coding frame only
	files <- list.files(dir, full.names = TRUE)	
	simple <- grep("verb-coding_frame-microroles", files)
	
	# read all data
	data <- sapply(files[simple], read.delim, quote="", simplify = FALSE)
	data <- do.call(rbind, data)
	rownames(data) <- NULL
		
	# select only basic coding frames
	data <- data[data$Basic_or_derived_coding_frame == "Basic", ]

	# remove empty coding
	data <- data[data$Coding_set_name != "", ]
		
	# correct minor typo
	wrong <- which(levels(data$Coding_set_name) == "með +NP-dat")
	levels(data$Coding_set_name)[wrong] <- "með+NP-dat"
	
	return(data)
}

# ==========

separate.coding <- function(coding) {
	
	splitnames <- unlist(strsplit(coding, split = ": "))
	dim(splitnames) <- c(2, length(splitnames)/2)
	n <- splitnames[1,]
	
	elements <- strsplit(splitnames[2,], split = " & | ")
	
	l <- sapply(elements,length)
	
	originals <- rep(coding, times = l)
	names <- rep(n, times = l)
	parts <- paste(names, unlist(elements), sep=": ")
	
	O <- qlcMatrix::ttMatrix(originals, simplify = T)
	P <- qlcMatrix::ttMatrix(parts, simplify = T)
	
	OP <- Matrix::tcrossprod(O, P)
	return(OP)
}

# ==========

role.dist <- function(data, ignore = 0, separate = FALSE) {
	
	# only microroles and language-unique coding sets
	# using sparse matrix implementation here
	
	R <- qlcMatrix::ttMatrix(as.character(data$Microrole_name), simplify = TRUE)
	C <- qlcMatrix::ttMatrix(paste(data$Language_name, data$Coding_set_name, sep = ": "), simplify = TRUE)

	RC <- tcrossprod(R,C)
	low.freq <- rowSums(RC) < ignore
	RC <- RC[!low.freq,]
	
	if (separate) {
		CP <- separate.coding(colnames(RC))
		M <- RC %*% CP
	} else {
		M <- RC
	}
	
	sim <- qlcMatrix::cosSparse(t(M), weight = idf)
	d <- max(sim) - sim
	
	return(list(dist = d, data = RC))
}

# ==========

semantic.map <- function(points, language, data, ...) {
	
	lang <- grep(language, colnames(data))
	selection <- data[, lang] * 1
	
	duplicates <- rowSums(selection) > 1
	if (sum(duplicates) > 0) {
		selection[duplicates, ] <- 0
	}
	
	qlcVisualize::lmap(points, selection, ...)	
}



