## Cluster Analysis

This is an R script that was written to take 10,000 random sub-samples of a background gene list (i.e. all the genes encoded in a genome, or all the genes expressed in a particular tissue) and determine if clusters of genes occur signficantly more (or less often) in a gene list of interest than they do in a background gene list. 

CROC (https://github.com/emepyc/croc) will determine if genes within a list of genes you are interested in are found in clusters in the genome.  The R script provided here will take 10,000 random samples of genes from a background gene list, run CROC on each of these samples and determine the number of clusters found in each random sample.  From this the probability that the number of clusters found in your gene list of interest is higher or lower than expected by chance relative to the random subsamples from the background gene list is calculated.  For 10,000 random samples of ~1200 genes the code will take approximatey 8 - 12 hours to run on a MacBook Pro (3 GHz Intel Core i7 with 16 GB of RAM).

This program requires CROC.pl (https://github.com/emepyc/croc), a list of genes expressed in your tissue of interest or the genome of interest and a species specific reference file (refer to CROC descriptor for more information).  

This R code was developed on a MacBook Pro running MacOS 10.14. Code was written and tested in RStudio v  1.1.456 and R version 3.5.1.  Code developed using CROC developed by pignatelli_mig[AT]gva.es (version 14/4/09).

CROCAnalysis_ClusterBootstrapping.R is executed in R or Rstudio and the user is free to edit the input files to use their own data (places to alter the code are annotated)

Sample data is included in this repository
testgenelist.txt is a file with a list of "genes of interest" 
Amel_ovary2.csv is an example "background list"
AmelNew.5cols is a reference file giving chromosomal locations for all genes encoded in the honeybee genome (extracted from gff3 file obtained from NCBI (Apis mellifera v. 4.5)).
test.pdf is a sample output graph (code for producing the simulation and graph is in CROCAnalysis_ClusterBootstrapping.R)





