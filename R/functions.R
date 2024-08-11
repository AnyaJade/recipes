
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
    dplyr::filter(name == recipe) |>
    dplyr::pull(!!rlang::sym(part))|>
    stringr::str_split("; ") |> 
    unlist() 
  
  return(method)
}

get_recipe_names <- function(data, type) {
  recipe_names <- data |>
    dplyr::filter(section == type) |>
    dplyr::arrange(name) |>
    dplyr::pull(name)|>
    unique() 
    
  return(recipe_names)
}

get_recipes <- function(data, section) {
  recipes <- data |>
    get_recipe_names(section) |>
    purrr::map_chr(\(recipe) {
      knitr::knit_child(input = "child-dir/_child.qmd",
                        envir = environment(),
                        quiet = TRUE)
    }) 
  
  return(recipes)
}