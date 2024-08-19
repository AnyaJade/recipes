
plain_list <- function(...) {
  cat(paste0(c(...), collapse = "\n"))
  cat("\n")
}

bullet_list <- function(...) {
  cat(paste0("- ", c(...), collapse = "\n"))
  cat("\n")
}

get_part_of_recipe <- function(data, id_number, part){
  method <- data |> 
    dplyr::filter(id == id_number) |>
    dplyr::pull(!!rlang::sym(part))|>
    stringr::str_replace_all(c("Filling:" = "\nFilling:",
                               "Topping:" = "\nTopping:",
                               ":" = ":;")) |>
    stringr::str_split("; ") |> 
    unlist() 
  
  return(method)
}

get_recipe_ids <- function(data, type) {
  recipe_id <- data |>
    dplyr::filter(section == type) |>
    dplyr::arrange(name) |>
    dplyr::pull(id)|>
    unique() 
    
  return(recipe_id)
}

get_recipes <- function(data, section) {
  recipes <- data |>
    get_recipe_ids(section) |>
    purrr::map_chr(\(id) {
      knitr::knit_child(input = "child-dir/_child-recipe.qmd",
                        envir = environment(),
                        quiet = TRUE)
    }) 
  
  return(recipes)
}

get_part <- function(recipes, id, part){
  contents <- get_part_of_recipe(recipes, id, part)
  
  if(!is.na(contents[1])){
    knitr::knit_child(input = "child-dir/_child-part.qmd",
                      envir = environment(),
                      quiet = TRUE)  |>
      cat(sep = '\n')}
  
}