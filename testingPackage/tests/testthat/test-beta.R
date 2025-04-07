library(testthat)
library(tidyverse)

test_that("get_beta_parameters : works", {
  pop_avg <- pima %>%
    dplyr::pull(mass) %>%
    mean()
  
  pop_var <- pima %>%
    dplyr::pull(mass) %>%
    var() 
  
  body_avg_params <- get_beta_parameters(
    population_avg = pop_avg,
    population_var = pop_var
  )
  
  expect_equal(body_avg_params$alpha, -542.31575)
  expect_equal(body_avg_params$beta, 525.36445)
  
})

test_that("re-deriving beta mu and sd : works", {
  
  pop_beta_params <- list(alpha = 43.48505, beta = 126.4443)
  
  expect_equal(
    beta_mu(pop_beta_params$alpha,
            pop_beta_params$beta),
    0.2559007,
    tolerance = .001
  )
  
  expect_equal(
    beta_sd(pop_beta_params$alpha,
            pop_beta_params$beta),
    sqrt(0.001114001),
    tolerance = .000001
  )
  
})


test_that("deriving posterior beta mu and sd : works", {
  
  pima <- pima %>%
    filter(!is.na(class)) %>%
    mutate(diabetes = as.numeric(class))
  
  pop_avg <- pima %>%
    dplyr::pull(diabetes) %>%
    mean()
  
  pop_var <- pima %>%
    dplyr::pull(diabetes) %>%
    var() 
  
  pop_beta_params <- get_beta_parameters(
    population_avg = pop_avg,
    population_var = pop_var
  )
  
  # Try a fake small scenario for test
  n_success_lt_pop_avg <- 10
  n_success_gt_pop_avg <- 80
  n_attempts <- 100
  
  expect_true(
    posterior_beta_mu(
      pop_beta_params$alpha,
      pop_beta_params$beta,
      n = n_attempts,
      success = n_success_lt_pop_avg
    ) < pop_avg
  )
  
  expect_false(
    posterior_beta_mu(
      pop_beta_params$alpha,
      pop_beta_params$beta,
      n = n_attempts,
      success = n_success_lt_pop_avg
    ) > n_success_lt_pop_avg / n_attempts
  )
  
  expect_true(
    posterior_beta_mu(
      pop_beta_params$alpha,
      pop_beta_params$beta,
      n = n_attempts,
      success = n_success_gt_pop_avg
    ) > pop_avg
  )
})



test_that("beta dist processing - regression test : works", {
  # Filter out missing or problematic values if needed
  pima <- pima %>%
    filter(!is.na(class)) %>%
    mutate(diabetes = as.numeric(class))
  
  pop_avg <- pima %>%
    dplyr::pull(diabetes) %>%
    mean()
  
  pop_var <- pima %>%
    dplyr::pull(diabetes) %>%
    var() 
  
  # Derive alpha/beta parameters from population avg and var
  diabetes_params <- get_beta_parameters(
    population_avg = pop_avg,
    population_var = pop_var
  )
  
  alpha_prior <- diabetes_params$alpha
  beta_prior <- diabetes_params$beta
  
  # Sample a subset for testing
  set.seed(559)
  small_pima <- pima %>%
    sample_n(10)
  
  small_pima <- small_pima %>%
    mutate(
      posterior_diabetes_mu = posterior_beta_mu(alpha_prior, beta_prior, n = 1, success = diabetes),
      posterior_diabetes_sd = posterior_beta_sd(alpha_prior, beta_prior, n = 1, success = diabetes)
    )
  
  # Check a snapshot of the resulting dataframe
  expect_snapshot(small_pima)
})


test_that("get_beta_parameters : throws errors with non-numeric inputs", {
  expect_error(
    get_beta_parameters(
      population_avg = "test",
      population_var = "value"
    )
  )
  
  expect_error(
    get_beta_parameters(
      population_avg = "test",
      population_var = "value"
    ),
    "is.numeric\\(population_avg\\) is not TRUE"
  )
  
  expect_error(
    get_beta_parameters(
      population_avg = "test",
      population_var = 42
    ),
    "is.numeric\\(.*?\\) is not TRUE"
  )
  
  expect_error(
    get_beta_parameters(
      population_avg = 42,
      population_var = "test"
    ),
    "is.numeric\\(.*?\\) is not TRUE"
  )
})
