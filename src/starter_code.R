## create a new package in the root folder

usethis::create_package("./r_documentation_demo/documentPackage")

## fill in Description and Add license

usethis::use_mit_license("./r_documentation_demo/documentPackage/")

## create a ReadMe file and skeleton

usethis::use_readme_md("./r_documentation_demo/documentPackage/")

## 
usethis::use_testthat()

## Creates "tests" folder
## adds testthat as a suggests into your DESCRIPTION file
## adds Config/testhat/edition into your DESCRIPTION file

## Create a new test file based on the current file you have open in RStudio
usethis::use_test()

## Create a new test file with specified name
uesthis::use_test("temporary")

## Confirm your tests run
devtools::test()

## Check Test Coverage - % of lines of code in your packaged tested
devtools::test_coverage()

##




