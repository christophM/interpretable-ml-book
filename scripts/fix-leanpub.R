# adapted from: https://github.com/rdpeng/rprogdatascience/blob/leanpub/manuscript/fixmath.R
cargs <- commandArgs(TRUE)
infile <- cargs[1]

fixmath = function(doc0) {
  doc <- sub("^\\\\\\[$", "{\\$\\$}", doc0, perl = TRUE)
  doc <- sub("^\\\\\\]$", "{\\/\\$\\$}", doc, perl = TRUE)
  doc <- gsub("\\$\\$(\\S+)\\$\\$", "\\$\\1\\$", doc, perl = TRUE)
  doc <- gsub("\\$(\\S+)\\$", "{\\$\\$}\\1{\\/\\$\\$}", doc, perl = TRUE)
  # Adds pagebreaks for leanpub
  #doc = c("", "{pagebreak}","", doc)
  doc
}

fix_chapter_enum = function(doc0) {
  gsub("{-}", "", doc0, fixed = TRUE)
}

add_pagebreak = function(doc) {
  gsub("<!--{pagebreak}-->", "{pagebreak}", doc, fixed = TRUE)
}

process_file  = function(infile) {
  doc0 = readLines(infile)
  doc = fixmath(doc0)
  doc = fix_chapter_enum(doc)
  doc = add_pagebreak(doc)
  writeLines(doc, infile)
}

process_file(infile)
