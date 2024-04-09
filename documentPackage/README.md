
# documentPackage

<!-- badges: start -->
<!-- badges: end -->

The goal of documentPackage is to demonstrated using the roxygen library to generate documentation files for R objects, specifically user-defined functions. The package has two R files, which generate functions and objects related to the beta and gamma modeling distributions. Functions can be called to calculate mean and standard deviation values for either distribution, but the intend to demonstrate the various ways roxygen can document objects in a package.

A particular emphasis is placed on roxygen's functionality to either: 
1. Linking various R objects to a single, more detailed roxygen comment.
2. Providing each R object with their own detailed roxygen comment.

## Installation

You can install the development version of documPackage from [GitHub](https://github.com/) with:

``` r
# install.packages("roxygen2")
# install.packages("devtools")
devtools::install_github("TRMichelson/r_documentation_demo")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(documentPackage)
?get_beta_parameters
```

