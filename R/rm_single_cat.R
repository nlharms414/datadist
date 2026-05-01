#' @name rm_single_cat
#' @title Removes categorical variable columns with only one category.
#'
#' @description A function that removes categorical variables from a data frame
#' if they only contain one category. Desiged for use with chardist().
#'
#' @param df data frame to remove one category categorical variables from.
#'
#' @returns A data frame with categorical variables containing only one category
#' removed.
#'
#' @examples
#' # example code
#' head(rm_single_cat(penguins_raw))
#'
#' @export
#'

rm_single_cat <- function(df){

  check <- function(col) length(unique(col))==1

  if(length(which(sapply(df,check)))!=0) {
    return(df[,-c(which(sapply(df,check)))])
  } else {
    return(df)
  }

}
