# Script to append new recipe to a .qmd file.

source("R/functions.R")

recipes <- c("shortbread", "brownie")

invisible(purrr::map(sort(recipes), 
                     ~create_recipes(., my_file = "biscuits.qmd")))
