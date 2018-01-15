
## 1. Install (if needed) and load packages.

#specify the packages of interest
packages = c("ggplot2", "cowplot")

#use this function to check if each package is on the local machine
#if a package is installed, it will be loaded
#if any are not, the missing package(s) will be installed and loaded
package.check <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
    }
})

## 2. Read in input file

args <- commandArgs(trailingOnly=TRUE)

inputFile <- args[[1]]

dat <- read.table(inputFile, header=T, sep="\t", as.is=T)

# reformat gene set categories
dat[,1] <- gsub("_", " ", gsub("GO[0-9]+_", "", dat[,1]))
dat[,1] <- paste(toupper(substr(dat[,1], 1, 1)), tolower(substr(dat$GO, 2, nchar(dat[,1]))), sep="")

# reorder according to p-value
dat[,1] <- reorder(dat[,1], dat[,2])

# -log10 transform the p-value

dat[,2] <- -log10(dat[,2])

col1 <- colnames(dat)[1]
col2 <- colnames(dat)[2]

p <- ggplot(dat, aes_string(x=col1, y=col2)) + 
	geom_bar(stat="identity") + 
	geom_hline(yintercept=-log10(0.05), col="red") + 
	ylab(paste0("-log10(",col2,")")) + 
	xlab(col1) + 
	coord_flip() + 
	theme(axis.text=element_text(size=20), axis.title=element_text(size=20,face="bold"), plot.title=element_text(size=24, face="bold")) +
	ggtitle(gsub(".txt", "", gsub("_", " ", inputFile)))

pdf(gsub("txt","pdf", inputFile), width=12, height=7)
print(p)
dev.off()
