
#' Plot effects of linear model
effect_plot = function(mod, dat,  feature_names=NULL){
  X = get_effects(mod, dat)
  if(!missing(feature_names)){
    rownames(X) = feature_names
  }
  X = tidyr::gather(X)
  require("ggplot2")
  ggplot(X) +
    geom_hline(yintercept=0, linetype=4) +
    geom_boxplot(aes(x=key, y=value, group=key)) +
    coord_flip() +
    scale_y_continuous('Feature effect') +
    my_theme()
}

get_reference_dataset = function(dat){
  df = lapply(dat, function(feature){
    if(class(feature) == 'factor'){
      factor(levels(feature)[1], levels = levels(feature))
    } else {
      0
    }
  })
  data.frame(df)
}

get_effects = function(mod, dat){

  X = data.frame(predict(mod, type = 'terms'))

  # Nicer colnames
  colnames(X) = gsub('^X\\.', '', colnames(X))
  colnames(X) = gsub('\\.', ' ', colnames(X))

  # predict with type='terms' centers the results, so we have to add the mean again
  reference_X = predict(mod, newdata=get_reference_dataset(dat), type='terms')
  X_star = data.frame(t(apply(X, 1, function(x){ x - reference_X[1,names(X)]})))
  X_star
}
