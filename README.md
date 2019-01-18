# ClusterAnalysis

This is an R script that was written to take random sub-samples of a gene list and determined if the genes within that list are clustered together more often than we would expect by chance. 

This program requires CROC.pl (https://github.com/emepyc/croc), a list of genes expressed in your tissue of interest or the genome of interest and a species specific reference file (refer to CROC descriptor for more information).  

CROC will determine if genes within a list of genes you are interested in are found in clusters in the genome.  The R script provided here will take 10,000 random samples of genes from a full-gene list and calculate p-value to determine whether the genes in your gene list of interest are found more or less frequently in clusters than we would expect by chance.


