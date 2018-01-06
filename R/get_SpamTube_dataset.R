# Download the youtube datasets

urls = sprintf('http://lasid.sor.ufscar.br/labeling/datasets/%i/download/', 9:13)
ycomments = lapply(urls, read.csv, stringsAsFactors=FALSE)
ycomments = do.call('rbind', ycomments)
cleanFun <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}
ycomments$CONTENT = cleanFun(ycomments$CONTENT)
# Convert to ASCII
ycomments$CONTENT = iconv(ycomments$CONTENT, "UTF-8", "ASCII", sub="")

head(ycomments)

write.csv( x = ycomments, file = sprintf('%s/TubeSpam.csv', data_dir),row.names=FALSE)
