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
get_beta_parameters <- function(population_avg, population_var) {
  
  stopifnot(is.numeric(population_avg))
  stopifnot(is.numeric(population_var))

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

#' Calculate Posterior mu based on Beta distribution
#'
#' Calculate posterior mu and sd given priors, observations, and n success to
#' calculate
#'
#' @param prior_alpha beta distribution alpha parameter from population
#' @param prior_beta beta distribution beta parameter from population
#' @param n numeric value representing number of observations
#' @param success numeric value representing the number of success (positive) observations
#'
#' @rdname posterior_beta
#'
#' @export
#'
#' @examples
#'
#' ## Set up
#'
#' library(tidyverse)
#'
#' pop_avg <- pima %>%
#'  dplyr::pull(mass) %>%
#'  mean()
#'
#' pop_var <- pima %>%
#'  dplyr::pull(mass) %>%
#'  var() 
#'
#' mass_avg_params <- get_beta_parameters(
#'   population_avg = pop_avg,
#'   population_var = pop_var
#' )
#'
#' ma_alpha_prior <- mass_avg_params$alpha
#' ma_beta_prior <- mass_avg_params$beta
#'
#' ## Using the functions
#'
#' set.seed(559)
#'
#' small_mass <- pima %>%
#'  sample_n(size = 10)
#'
#' small_mass %>%
#'    mutate(
#'       posterior_batting_avg = posterior_beta_mu(ma_alpha_prior, ma_beta_prior, n = DB, success = 1),
#'       posterior_batting_sd = posterior_beta_sd(ma_alpha_prior, ma_beta_prior, n = DB, success = 1)
#'       )
#'
posterior_beta_mu <- function(prior_alpha, prior_beta, n, success){
  
  posterior_alpha <- prior_alpha + success
  posterior_beta <- prior_beta + (n - success)
  
  mu <- posterior_alpha / (posterior_alpha + posterior_beta)
  return(mu)
}

#' @rdname posterior_beta
#' @export
posterior_beta_sd <- function(prior_alpha, prior_beta, n, success){
  
  posterior_alpha <- prior_alpha + success
  posterior_beta <- prior_beta + (n - success)
  
  s <- sqrt(pmax((posterior_alpha * posterior_beta) / ((posterior_alpha + posterior_beta)^2 * (posterior_alpha + posterior_beta + 1)),0))
  return(s)
}
