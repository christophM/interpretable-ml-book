# from: https://github.com/rdpeng/rprogdatascience/blob/leanpub/manuscript/fixmath.R
# Author: Roger D. Peng
cargs <- commandArgs(TRUE)
infile <- cargs[1]

fixmath <- function(infile) {
  doc0 <- readLines(infile)
  doc <- sub("^\\\\\\[$", "{\\$\\$}", doc0, perl = TRUE)
  doc <- sub("^\\\\\\]$", "{\\/\\$\\$}", doc, perl = TRUE)
  doc <- gsub("\\$\\$(\\S+)\\$\\$", "\\$\\1\\$", doc, perl = TRUE)
  doc <- gsub("\\$(\\S+)\\$", "{\\$\\$}\\1{\\/\\$\\$}", doc, perl = TRUE)
  # Adds pagebreaks for leanpub
  doc = c("", "{pagebreak}","", doc)
  writeLines(doc, infile)
}

fixmath(infile)
