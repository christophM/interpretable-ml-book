library("xml2")

target_dir = "../vgwort/"
html_dir = "../manuscript/_book/"

VGWORT_NCHAR_MIN = 1800
file_list = list.files(html_dir)
file_list = file_list[grep(".html", file_list)]

exclude_files = list("acknowledgements.html",
                     "anchors.html",
                     "detecting-concepts.html",
                     "preface-by-the-author.hml",
                     "index.html",
                     "translations.html",
                     "404.html", 
                     "references.html",
                     "intro.html",
                     "r-packages-used.html",
                     "preface-by-the-author.html")

file_list = setdiff(file_list, exclude_files)

xx = lapply(file_list, function(filename) {
  # Read in the document
  doc <- read_xml(sprintf("%s%s", html_dir, filename))
  # find the right section in the html 
  x = xml_find_all(doc, ".//section[@id='section-']")
  # extract the text
  txt = xml_text(x)
  text_length =  nchar(txt)
  if (text_length > VGWORT_NCHAR_MIN) {
  # Write the text to file
  write(txt, file = sprintf("%sraw-text/%s.txt", target_dir, filename))
  data.frame(filename = filename, ncharacters = text_length) 
  }
})

results = data.table::rbindlist(xx)

write.csv(results, sprintf("%s00-word-count.csv", target_dir))

