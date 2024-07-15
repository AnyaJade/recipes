# Script to append new recipe to a .qmd file.

# Function definition ----
#' Create recipe layout
#' 
#' Appends code to a .qmd file to create the layout for a recipe.
#'
#' @param recipe The recipe to write.
#' @param my_file The .qmd to append too.
#'
#' @return Appends code to .qmd file.
create_recipe_layout <- function(recipe, my_file) {
  cat(
    "## ",
    stringr::str_to_title(recipe),
    "\n",
    # column
    "\n:::: {.columns}\n",
    "\n::: {.column width=\"70%\"}\n",
    # ingredients
    "\n```{r}\n",
    "get_part_of_recipe(recipes, \"", 
    recipe, 
    "\", \"ingredients\") |>
  plain_list()",
    "\n```",
    "\n",
    # method
    "\n```{r}\n",
    "get_part_of_recipe(recipes, \"", 
    recipe, 
    "\", \"method\") |>
    bullet_list() ",
    "\n```\n",
    # column
    "\n:::\n",
    # empty column for gap
    "\n::: {.column width=\"10%\"}\n",
    "\n:::\n",
    # column open
    "\n::: {.column width=\"20%\"}\n",
    # details
    "\n `r get_part_of_recipe(recipes, \"", recipe, "\", \"temperature\")`C",
    "\n \n",
    "`r get_part_of_recipe(recipes, \"", recipe, "\", \"time\")`mins",
    "\n \n",
    "`r get_part_of_recipe(recipes, \"", recipe, "\", \"quantity\")` x 
    `r get_part_of_recipe(recipes, \"", recipe, "\", \"size\")` \n",
    # column close
    "\n:::\n",
    "\n::::\n",
    sep = "",
    append = TRUE,
    file = my_file
  )
}

# Apply function ----
invisible(purrr::map("shortbread", 
                     ~create_recipe_layout(., my_file = "biscuits.qmd")))