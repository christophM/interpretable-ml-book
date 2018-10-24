#' Kernel function
#'
#' @param d Distance between center and point
#' @param kernel_width Width of kernel
kernel = function(d, kernel_width){
  sqrt(exp(-(d^2) / kernel_width^2))
}

#' Get euclidean distances of samples to instances to be explained
#' @param point_explain Vector of scaled features
#' @param points_sample data.frame of scaled features for the sample points
#' @return Vector with distances of samples to instance to be explained
get_distances = function(point_explain, points_sample){
  # euclidean distance
  apply(points_sample, 1, function(x){
    sum((point_explain - x)^2)
  })
}

# Function for creating y values
get_y = function(x1, x2, noise_prob = 0){
  y = sign(sign(x2-1+abs(x1*2))/3 - sign(x2-.5+abs(x1*3))/3) + 1
  y = y * (1 - rbinom(length(x1), 1, prob = noise_prob))
  # flip classes
  y = 1 - y
  y
}














