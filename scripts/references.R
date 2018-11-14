library("data.table")
library("readr")

# relative project path to the .Rmd files
path = "./"
# name of the file where to write the references to
out.file = "10-references.Rmd"

# Function to collect list of .Rmd files
get_file_list = function(folder){
  paste(folder, list.files(folder, pattern = ".Rmd"), sep = "/")
}

# Function to create a list of references from list of .Rmd
grep_references = function(file){
  # read in file as string
  lines = readr::read_lines(file)
  # grep lines starting with[^XXX]:
  lines = lines[grep("\\[\\^[a-z;A-Z]*\\]\\:", lines)]
  # split by first :
  splitted = strsplit(lines, "]: ")
  # store in data.frame with key and ref
  res = data.table::rbindlist(lapply(splitted, function(x) data.frame(t(x), stringsAsFactors = FALSE)))
  if(nrow(res) > 0) {
    colnames(res) = c("key", "reference")
    res$key = gsub("\\[\\^", "", res$key)
  }
  res
}


file_list = get_file_list(path)
file_list = setdiff(file_list, paste(path, "interpretable-ml.Rmd", sep = "/"))
reference_list = data.table::rbindlist(lapply(file_list, grep_references), fill = TRUE)

reference_list = unique(reference_list)
reference_list = reference_list[order(reference_list$reference),]



fileConn <-file(paste(path, out.file, sep = "/"))
write_string = c("# References {-}",
  "<!-- Generated automatically, please don't edit manually! -->")
for(i in 1:nrow(reference_list)) {
  write_string = c(write_string, "", reference_list$reference[i])
}
write_lines(write_string, fileConn)



