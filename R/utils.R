#' Make character vector pretty
pretty_rownames = function(rnames){
  rnames = gsub('^`', '', rnames)
  rnames = gsub('`$', '', rnames)
  rnames = gsub('`', ':', rnames)
  rnames
}
