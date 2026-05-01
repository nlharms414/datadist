#' @name chardist_XY
#' @title Compares two catecorical (or factor) columns between two data sets.
#'
#' @description
#' The distance between two character (or factor) variables is being calculated.
#'
#' @param varA vector from dataset A
#' @param varB vector from dataset B
#'
#' @returns A a binary response indicating if two variables are identical, a
#' marginal distance between the two variables as factors, and objects
#' returned by use of dscore().
#'
#' @importFrom stats model.matrix
#'
#' @examples
#' # example code
#' chardist_XY(penguins$species, penguins_raw$Sex)
#'
#' @export

chardist_XY <- function(varA, varB) {
  stopifnot(is.character(varA) | is.factor(varA),
            is.character(varB) | is.factor(varB))
  cl <- match.call()
  nameA = cl$varA
  nameB = cl$varB
  nA = length(varA)
  nB = length(varB)
  if (nA == nB) {
    same_values <- all(varA == varB)
    if (!same_values) {
      message("use the stringdist package to find a string distance between the values")
    }
  }

  # check character distance first:
  varA_char <- as.character(varA)
  varB_char <- as.character(varB)

  if (length(unique(varA_char)) == 1) {
    dfA <- data.frame(model.matrix(~1))
    names(dfA) <- varA_char[1]
  } else {
    dfA <- data.frame(model.matrix(~varA_char-1))
    names(dfA) <- gsub("^varA_char", "", names(dfA))
  }
  if (length(unique(varB_char)) == 1) {
    dfB <- data.frame(model.matrix(~1))
    names(dfB) <- varB_char[1]
  } else {
    dfB <- data.frame(model.matrix(~varB_char-1))
    names(dfB) <- gsub("^varB_char", "", names(dfB))
  }
  charmat <- numdist(dfA, dfB)

  # check factor distance:
  varA_factor <- ifelse(is.factor(varA), varA, factor(varA))
  varB_factor <- ifelse(is.factor(varB), varB, factor(varB))

  dist_factor <- wassersteinXY(as.numeric(varA_factor), as.numeric(varB_factor))

  return(list(identical=same_values, `marginal distance` = dist_factor,
              distmat = dscore(charmat)))
}
