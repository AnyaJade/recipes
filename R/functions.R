
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
