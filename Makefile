all: report.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.html

words.txt:
	Rscript -e 'download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile="words.txt", quiet=TRUE)'

histogram.tsv: histogram.r words.txt
	Rscript $<

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

report.html: report.rmd histogram.tsv histogram.png
	# have to set path to Pandoc so system can find it from command line
	Rscript -e 'Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio/resources/app/bin/quarto/bin/tools/x86_64");rmarkdown::render("$<")'