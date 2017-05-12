

## Defining functions

#' Kernel function
#'
#' @param d Distance between center and point
#' @param kernel_width Width of kernel
kernel = function(d, kernel_width){
  sqrt(exp(-(d^2) / kernel_width^2))
}

#' Get euclidean distances of samples to instances to be explainedß
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



## Creating dataset ###########################################################


# Define range of set
lower_x1 = -2
upper_x1 = 2
lower_x2 = -2
upper_x2 = 1

# Size of the training set for the black box classifier
n_training  = 20000
# Size for the grid to plot the decision boundaries
n_grid = 100
# Number of samples for LIME explanations
n_sample = 500


# Simulate y ~ x1 + x2
set.seed(1)
x1 = runif(n_training, min = lower_x1, max = upper_x1)
x2 = runif(n_training, min = lower_x2, max = upper_x2)
y = get_y(x1, x2)
# Add noise
y_noisy = get_y(x1, x2, noise_prob = 0.01)
lime_training_df = data.frame(x1=x1, x2=x2, y=as.factor(y), y_noisy=as.factor(y_noisy))

# For scaling later on
x_means = c(mean(x1), mean(x2))
x_sd = c(sd(x1), sd(x2))


# Learn model
rf = randomForest::randomForest(y_noisy ~ x1 + x2, data = lime_training_df, ntree=100)
lime_training_df$predicted = predict(rf, lime_training_df)


# The decision boundaries
grid_x1 = seq(from=lower_x1, to=upper_x1, length.out=n_grid)
grid_x2 = seq(from=lower_x2, to=upper_x2, length.out=n_grid)
grid_df = expand.grid(x1 = grid_x1, x2 = grid_x2)
grid_df$predicted = as.numeric(as.character(predict(rf, newdata = grid_df)))


# The observation to be explained
explain_x1 = 1
explain_x2 = -0.5
explain_y_model = predict(rf, newdata = data.frame(x1=explain_x1, x2=explain_x2))
df_explain = data.frame(x1=explain_x1, x2=explain_x2, y_predicted=explain_y_model)

point_explain = c(explain_x1, explain_x2)
point_explain_scaled = (point_explain - x_means) / x_sd

# Drawing the samples for the LIME explanations
x1_sample = rnorm(n_sample, x_means[1], x_sd[1])
x2_sample = rnorm(n_sample, x_means[2], x_sd[2])
df_sample = data.frame(x1 = x1_sample, x2 = x2_sample)
# Scale the samples
points_sample = apply(df_sample, 1, function(x){
  (x - x_means) / x_sd
}) %>% t



# Add weights to the samples
kernel_width = sqrt(dim(df_sample)[2]) * 0.15
distances = get_distances(point_explain_scaled, 
                          points_sample = points_sample)

df_sample$weights = kernel(distances, kernel_width=kernel_width)

df_sample$predicted = predict(rf, newdata = df_sample)


# Trees
# mod = rpart(predicted ~ x1 + x2, data = df_sample,  weights = df_sample$weights)
# grid_df$explained = predict(mod, newdata = grid_df, type='prob')[,2]

# Logistic regression model
mod = glm(predicted ~ x1 + x2, data = df_sample,  weights = df_sample$weights, family='binomial')
grid_df$explained = predict(mod, newdata = grid_df, type='response')

# logistic decision boundary
coefs = coefficients(mod)
logistic_boundary_x1 = grid_x1
logistic_boundary_x2 = -  (1/coefs['x2']) * (coefs['(Intercept)'] + coefs['x1'] * grid_x1) 
logistic_boundary_df = data.frame(x1 = logistic_boundary_x1, x2 = logistic_boundary_x2)  
logistic_boundary_df = filter(logistic_boundary_df, x2 <= upper_x2, x2 >= lower_x2)


# Create a smaller grid for visualization of local model boundaries
x1_steps = unique(grid_df$x1)[seq(from=1, to=n_grid, length.out = 20)]
x2_steps = unique(grid_df$x2)[seq(from=1, to=n_grid, length.out = 20)]
grid_df_small = grid_df[grid_df$x1 %in% x1_steps & grid_df$x2 %in% x2_steps,]
grid_df_small$explained_class = round(grid_df_small$explained)










