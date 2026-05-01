#' @name chardist
#' @title Generates distance matrix for categorical columns in two data sets.
#'
#' @description
#' Computes a distance matrix and distance (similarity) score for the categorical
#' columns in two data sets.
#'
#' @param dfa data set A to compare to data set B.
#' @param dfb data set B to compare to data set A.
#'
#' @returns A distance matrix for the categorical variables between two data
#' sets.
#'
#' @examples
#' chardist(penguins,penguins_raw)
#'
#' @export

chardist <- function(dfa,dfb){
  cl <- match.call()

  name_dfa <- deparse(cl$dfa)
  name_dfb <- deparse(cl$dfb)

  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) || all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  # remove date columns and categorical columns with only one category
  charA <- date_cols(rm_single_cat(a[sapply(a,is.numeric)==F]),add=F)
  charB <- date_cols(rm_single_cat(b[sapply(b,is.numeric)==F]),add=F)

  index <- expand.grid(1:length(charA),1:length(charB))

  result <- apply(index, 1, function(x) {
    suppressMessages(chardist_XY(charA[,x[1]], charB[,x[2]])$distmat$distscore)
  })

  matrix(result, nrow=ncol(charA),
         dimnames = list(colnames(charA), colnames(charB)))

}

