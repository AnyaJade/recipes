
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
  recipe_names <- recipes |>
    dplyr::filter(section == type) |>
    dplyr::arrange(name) |>
    dplyr::pull(name)|>
    unique() 
    
  
  return(recipe_names)
}
