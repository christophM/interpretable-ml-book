#' Make character vector pretty
pretty_rownames = function(rnames){
  rnames = gsub('^`', '', rnames)
  rnames = gsub('`$', '', rnames)
  rnames = gsub('`', ':', rnames)
  rnames
}


year_diff = function(date1, date2){
  day_diff(date1, date2) / 365.25
}


