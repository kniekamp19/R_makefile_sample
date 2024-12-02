words <- read.csv('~/workspace/R_makefile_sample/words.txt', header=FALSE)$V1
nchar.table <- as.data.frame(table(nchar(words)))
colnames(nchar.table) <- c('Length','Freq')
write.table(nchar.table,file='~/workspace/R_makefile_sample/histogram.tsv',
            row.names=FALSE, sep='\t', quote=FALSE)
