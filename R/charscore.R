#' @name charscore
#' @title Generates distance score for categorical columns.
#'
#' @description
#' Computes a distance matrix and distance (similarity) score for the categorical
#' columns in two data sets.
#'
#' @param dfa Data frame A to compare to `dfb`
#' @param dfb Data frame B to compare to `dfa`
#'
#' @examples
#' # example code
#'
#' @export
#'
#' @returns A list containing a matrix containing distance scores between
#' categorical variables from two datasets.

charscore <- function(dfa,dfb){
  index <- expand.grid(1:length(dfb),1:length(dfb))
  score <- function(index,catA,catB){
    d <- datadist(data.frame(model.matrix(~catA[,index[1]]-1, data = catA)),
                  data.frame(model.matrix(~catB[,index[2]]-1, data = catB)))$numdist
    rownames(d) <- sort(unique(catA[,index[1]]))
    colnames(d) <- sort(unique(catB[,index[2]]))
    numscore(d)$score
  }

  matrix(apply(index,1,score,catA=dfa,catB=dfb), nrow=ncol(dfa),
         dimnames = list(colnames(dfa), colnames(dfb)))
  }
