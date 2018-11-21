# adapted from: https://github.com/rdpeng/rprogdatascience/blob/leanpub/manuscript/fixmath.R
cargs <- commandArgs(TRUE)
infile <- cargs[1]


# Removes out.width, which is needed in HTML version, but 
# when converting to .md, leads to html image input, instead of ![]() notation
# which causes problems with leanpub
fix_image_params = function(doc){
  gsub("\\s*,\\s*out.width\\s*=\\s*\\d+", "", doc)
}

process_doc  = function(doc0) {
  doc = fix_image_params(doc0)
}

# Make changes and write to disc
doc0 = readLines(infile)
doc = process_doc(doc0)
writeLines(doc, infile)

# knit stuff
knitr::knit(infile, envir = new.env())

# Write again the original doc
writeLines(doc0, infile)