## create a new package

usethis::create_package("testingPackage")

## fill in Description and Add license

usethis::use_mit_license()

## create a ReadMe file and skeleton

usethis::use_readme_md()

## create function scripts, placing them in the R script folder 'R/'
usethis::use_r('beta_dist')
usethis::use_r('gamma_dist')

## devtools::documentation()
## roxygen2::roxygenize()
##
## finally, press the install button

# @title, @description, @details
# This introductory block is broken up as follows:
# - The first sentence is the title:
#   that’s what you see when you look at help(package = mypackage) and
#   is shown at the top of each help file. It should generally fit on one line,
#   be written in sentence case, and not end in a full stop.
#
# - The second paragraph is the description:
#   this comes first in the documentation and should briefly describe what the function does.
#
# - The third and subsequent paragraphs go into the details:
#   this is a (often long) section that comes after the argument description
#   and should provide any other important details of how the function operates.
#   The details are optional.

# @param
# The @param is a tag used to document parameters (arguments) of a function in
# R source files.
# - Typical format is '@param param_name Description'
# This documentation is then accessible to users of your package through tools like ? and help()

# @return
# The @return tag is used to document the return value of the function.
# - Typical format is '@return Description'
# It allows you to provide information about the data type of the return value and a brief description of what it represents.

# @export
# In R package development, @export is used to indicate that a specific function should be exported from the package namespace.
#
# When you create an R package, functions are not accessible to users of the package by default.
# Only functions that are explicitly marked with @export will be included in the package's namespace,
# meaning they can be called directly by users of the package without specifying the package name.
#
# i.e.
# When the package is built and loaded, functions marked with @export are included in the package's namespace.
# This means users can call them directly without needing to prepend the package name.
# For example, if my_function is marked with @export in the yourpackage package,
# users can simply call my_function() without needing to write yourpackage::my_function().

# @rdname
# By default, the documentation file associated with objects in R will be titled name_of_object.Rd.
# The @rdname tag is used to specify the name of the documentation file where this object's documentation should be placed.
#
# This is particularly useful when you have multiple objects documented in different files,
# but you want them all to be combined into a single documentation page.
# By specifying the same @rdname for each object, Roxygen2 will group them together in the same documentation file.

