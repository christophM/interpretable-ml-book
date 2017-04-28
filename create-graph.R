library('DiagrammeR')
library('rpart')


rp = rpart(dist ~ speed, data = cars)

nodes = rp$frame[c('var')]
#nodes = rbind(nodes, data.frame(var = 'root'))
depths = rpart:::tree.depth(as.numeric(row.names(rp$frame)))
edges = data.frame(from = NULL, to = NULL, label=NULL)
for(i in 1:(nrow(rp$frame) - 1)){
  if(depths[i] == (depths[i+1] - 1)){
    possible_childs = which(depths == (depths[i]+1))
    next_childs = possible_childs[possible_childs > i][1:2]
    edges = rbind(edges, data.frame(from = i, to = next_childs, label = c('y', 'n')))
  }
}
edges$label = as.character(edges$label)



## TODO: Write function to assign the labels to the parents instead of the child nodes
labels(rp)

graph = create_graph()
graph = add_nodes_from_table(graph, nodes, label_col = 'var', type_col = 'var')
graph = add_edge_df(graph, edges)
graph$global_attrs[graph$global_attrs == 'layout', 'value'] = 'dot'
render_graph(graph, output = 'graph')

library('party')
set.seed(42)
n = 100
dat = data.frame(feature_x1 = rep(c(1,1,2,2), times = n), feature_x2 = rep(c(2,3,3,3), times = n), y = rep(c(1, 2, 3, 4), times = n))
dat = dat[sample(1:nrow(dat), size = 0.9 * nrow(dat)), ]
dat$y = dat$y + rnorm(nrow(dat), sd = 0.2)
ct = ctree(y ~ feature_x1 + feature_x2, dat)
plot(ct, inner_panel = node_inner(ct, pval = FALSE))



library('grid')

grid.newpage()

grid.rect()





