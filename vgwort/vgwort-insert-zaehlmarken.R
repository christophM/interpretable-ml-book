# Script to insert VGWORT Zaehlmarken into the html pages

# Directory where the HTML files can be found
book_dir = '../manuscript/_book/'

# File that matches HTML filenames to the Zaehlmarken
zaehlmarken_filename = '../vgwort/2022-07-06-zaehlmarken.csv'


zaehlmarken = read.csv(zaehlmarken_filename, sep = ";")

apply(zaehlmarken, 1, function(x) {
  fname = x[["filename"]]
  txt = paste(readLines(sprintf("%s%s", book_dir, fname)), collapse = "\n")
  txt2 = strsplit(txt, split = "</body>", fixed = TRUE)
  # if zaehlmarke not present, insert
  if(!grepl(x[["zaehlmarke"]], txt2[[1]][[1]])) {
    new_html = paste(c(txt2[[1]][[1]], x[["zaehlmarke"]], "</body>", txt2[[1]][[2]]), collapse = "\n")  
    write(new_html, file = sprintf("%s%s", book_dir, fname))
  }
})











