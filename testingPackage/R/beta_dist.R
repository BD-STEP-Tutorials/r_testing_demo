#' @title Get beta distribution parameters
#'
#' @description Based on the population average and variance, calculate the alpha and beta
#' parameters that describe the beta distribution.
#'
#' @details The beta distribution should be used when the distribution being predicting
#' is a value between 0 and 1.
#'
#' @param population_avg the population average, a length 1 numeric value
#'   describing the average (mean) value of the population
#' @param population_var the population variance, a length 1 numeric value
#'   describing the variance of the population
#'
#' @return a list object with numeric elements
#'
#' @examples
#' ## Generate data following a beta distribution
#' library(MASS)
#'
#' brain_standardized <- scale(Animals$brain)
#' beta_data <- (brain_standardized - min(brain_standardized)) / (max(brain_standardized) - min(brain_standardized))
#'
#' beta_mean <- mean(beta_data)
#' beta_var <- var(beta_data)
#'
#' ## Using the function
#' beta_parameters <- get_beta_parameters(
#'  population_avg = beta_mean,
#'  population_var = beta_var
#' )
#' beta_parameters
#'
#' @export
get_beta_parameters <- function(population_avg, population_var){

  alpha <- population_avg * (population_avg * (1 - population_avg)/population_var - 1)
  beta <- alpha * (1 - population_avg)/population_avg

  list(alpha = alpha, beta = beta)
}

#' @title Beta Distribution Parameter - mu & sd
#'
#' @description Calculate mean from alpha and beta parameters of a
#' beta distribution
#'
#' @param alpha alpha parameter of a beta distribution
#' @param beta beta parameter of a beta distribution
#'
#' @rdname beta
#'
#' @return a numeric object
#'
#' @export
beta_mu <- function(alpha, beta){

  mu <- alpha / (alpha + beta)
  return(mu)
}

#' @description Calculate standard deviation from alpha and beta parameters of a
#' beta distribution
#'
#' @rdname beta
#'
#' @return a numeric object
#'
#' @export
beta_sd <- function(alpha, beta){

  s <- sqrt((alpha * beta) / ((alpha + beta)^2 * (alpha + beta + 1)))
  return(s)

}
