#Tested with RStudio v  1.1.456 and R version 3.5.1
#place the AmelNew.5cols file into the Species folder of the CROC standalone applicaton (https://github.com/emepyc/croc) all other files can be in the main CROC directory

#This code tests a gene list to see how many 'clusters' of genes are present in your list
system("perl croc.pl --allPerl -g 5 -m 3 -t BH -p 0.01  --reg testgenelist.txt --ref Species/AmelNew.5cols >testgenelist_out.txt")
test=read.csv("testgenelist_out.txt", header=FALSE) #number of clusters identified in test data
c=nrow(test) #this value is used to calculate significance later in the text


#bootstrapping approach for cluster signficance
genelist=read.csv("Amel_ovary2.csv", header=FALSE) # this is all of the genes that are expressed (RPKM>1) in the honeybee ovary
genelist1=data.frame(unique(genelist$V1))

vec=NULL #make a file called vec for results
vec=data.frame() #make vec a data frame
X=NULL #make sure X is empty prior to starting analysis (X is a temporary file in this loop)

#loop runs 10,000 times each time picking n genes from a list and running the perl script "croc.pl" over the list.  The number of genes is user defined. 
for(i in 1:1000) {n=1286 #n is user defined and this is the number of genes in the original gene list of interest
  X=genelist1[sample(nrow(genelist1), n), ]
  write.table(X, "X.txt", row.names=FALSE, quote=FALSE, col.names = FALSE)
  system("perl croc.pl --allPerl -g 5 -m 3 -t BH -p 0.01  --reg X.txt --ref Species/AmelNew.5cols >output.txt") #AmelNew.5cols must be placed in the Species folder of CROC
  output=tryCatch(read.table("output.txt", fill=TRUE, row.names=NULL), error=function(e) output=data.frame()) #error recovery if no output then output empty data frame
  is.null(output)  
  vec <- c(vec, (nrow(output)))
}

m=matrix(vec)
n=as.numeric(m)

write.csv(n, "Bootstrap_Cluster.csv", quote=FALSE) #user defined filename
data <- factor(n, levels = c(0:max(n)))
xout <- as.data.frame(table(data))
xout <- transform(xout, cumFreq = cumsum(Freq), relative = prop.table(Freq))


#pvalue calculation
xout$data=as.character(xout$data) #have to convert from factor to character to numeric otherwise it renames the data
xout$data=as.numeric(xout$data)

"Less clusters than expected (p-value)" 
xout1=subset(xout,data<c)
p1=sum(xout1$Freq, na.rm=TRUE)/1000 
p1

"More clusters than expected (p-value)" 
xout2=subset(xout,data>c)
p2==sum(xout2$Freq, na.rm=TRUE)/1000
p2


xout2=subset(xout,data>=c)
p3=sum(xout2$Freq, na.rm=TRUE)/10000
p3

#graph with fitted normal dist to visualise bootstrapped clusters
roundUp <- function(x) 10^ceiling(log10(x))
roundUp(max(xout$Freq))

pdf(file = "test.pdf", width=8.27 , height=8.27)
h=hist(n, border="light gray", xlab="number of clusters detected", main="-w 50000 -o 1000 -m 3 -t BH -p 0.01", include.lowest = TRUE, ylim=c(0,roundUp(max(xout$Freq))), xlim=c(0,signif(max(n), digits=1)),right=FALSE, breaks=seq(0,100,by=1))
h

xfit<-seq(min(n),max(n),length=10000)
yfit<-dnorm(xfit,mean=mean(n),sd=sd(n)) 
yfit <- yfit*diff(h$mids[1:2])*length(n) 
lines(xfit, yfit, col="blue", lwd=2)
abline(v=c, col=c("red"), lty=2, lwd=5) 
text(c+(0.2*c),(roundUp(max(xout$Freq))-50), paste("p-value =", p2), cex=0.8) 
dev.off()


