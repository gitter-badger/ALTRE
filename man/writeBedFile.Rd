% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/writerfunctions.R
\name{writeBedFile}
\alias{writeBedFile}
\title{Creates a custom track for visualization on genome browser}
\usage{
writeBedFile(analysisresults, con)
}
\arguments{
\item{analysisresults}{output generated from categAltrePeaks()}

\item{con}{connection}
}
\description{
Creates a color-coded BED file for visualization of peaks and their ALTRE
categories in a genome browser: red indicates increased log2fold change/low
p-value, blue indicates decreased lod2fold change/low p-value, and purple
indicates regions with little to no change and insignificant p-values.
Based on the log2fold change and p-value inputs, there is a possibility that
some regions will not fulfill any of the supplied criteria
("in-between" shared and type-specific). They are colored grey.
}
\examples{
\dontrun{
dir <- system.file('extdata', package='ALTRE', mustWork=TRUE)
csvfile <- file.path(dir, 'lung.csv')
sampleinfo <- loadCSVFile(csvfile)
samplePeaks <- loadBedFiles(sampleinfo)
consPeaks <- getConsensusPeaks(samplepeaks=samplePeaks,minreps=2)
TSSannot <- getTSS()
consPeaksAnnotated <- combineAnnotatePeaks(conspeaks = consPeaks,
                                          TSS = TSSannot,
                                          merge = TRUE,
                                          regionspecific = TRUE,
                                          distancefromTSSdist = 1500,
                                          distancefromTSSprox = 1000)
#Need to run getcounts on all chromosomes
counts_consPeaks <- getcounts(annotpeaks = consPeaksAnnotated,
                             csvfile = csvfile,
                             reference = 'SAEC')
altre_peaks <- countanalysis(counts = counts_consPeaks,
                             pval = 0.01,
                             lfcvalue = 1)
categaltre_peaks <- categAltrePeaks(altre_peaks, lfctypespecific = 1.5,
lfcshared = 1.2, pvaltypespecific = 0.01, pvalshared = 0.05)
writeBedFile(categaltre_peaks)
}
}

