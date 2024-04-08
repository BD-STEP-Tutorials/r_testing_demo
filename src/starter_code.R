## create a new package in the root folder

usethis::create_package("./r_documentation_demo/documentPackage")

## fill in Description and Add license

usethis::use_mit_license("./r_documentation_demo/documentPackage/")

## create a ReadMe file and skeleton

usethis::use_readme_md("./r_documentation_demo/documentPackage/")