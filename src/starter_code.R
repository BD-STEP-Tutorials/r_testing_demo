## create a new package

usethis::create_package("testingPackage")

## fill in Description and Add license

usethis::use_mit_license()

## create a ReadMe file and skeleton

usethis::use_readme_md()

## create function scripts, placing them in the R script folder 'R/'
usethis::use_r('beta_dist')
usethis::use_r('gamma_dist')
