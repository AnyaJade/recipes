
plain_list <- function(...) {
  cat(paste0(c(...), collapse = "\n"))
  cat("\n")
}

bullet_list <- function(...) {
  cat(paste0("- ", c(...), collapse = "\n"))
  cat("\n")
}

get_part_of_recipe <- function(data, recipe, part){
  method <- data |> 
    filter(name == recipe) |>
    pull(!!rlang::sym(part))|>
    str_split("; ") |> 
    unlist() 
  
  return(method)
}

# Function definition ----
#' Create recipe layout
#' 
#' Appends code to a .qmd file to create the layout for a recipe.
#'
#' @param recipe The recipe to write.
#' @param my_file The .qmd to append too.
#'
#' @return Appends code to .qmd file.
create_recipes <- function(r, my_file) {
  cat(
    "## ",
    stringr::str_to_title(r),
    "\n",
    # column
    "\n:::: {.columns}\n",
    "\n::: {.column width=\"70%\"}\n",
    # ingredients
    "\n```{r}\n",
    "get_part_of_recipe(recipes, \"", 
    r, 
    "\", \"ingredients\") |>
  plain_list()",
    "\n```",
    "\n",
    # method
    "\n```{r}\n",
    "get_part_of_recipe(recipes, \"", 
    r, 
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
    "\n `r get_part_of_recipe(recipes, \"", r, "\", \"temperature\")`C",
    "\n \n",
    "`r get_part_of_recipe(recipes, \"", r, "\", \"time\")`mins",
    "\n \n",
    "`r get_part_of_recipe(recipes, \"", r, "\", \"quantity\")` x 
    `r get_part_of_recipe(recipes, \"", r, "\", \"size\")` \n",
    # column close
    "\n:::\n",
    "\n::::\n",
    sep = "",
    append = TRUE,
    file = my_file
  )
}