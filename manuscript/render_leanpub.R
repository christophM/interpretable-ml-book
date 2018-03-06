args = commandArgs(trailingOnly=TRUE)

rmarkdown::render(args[1], output_format = "md_document", envir = new.env())

