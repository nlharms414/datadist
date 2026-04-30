#' @name chardist
#' @title Generates distance matrix for categorical columns in two data sets.
#'
#' @description
#' Computes a distance matrix and distance (similarity) score for the categorical
#' columns in two data sets.
#'
#' @param dfa Data frame A to compare to `dfb`
#' @param dfb Data frame B to compare to `dfa`
#'
#' @examples
#' chardist(penguins[, c("species", "island", "sex")],
#'          penguins_raw[, c("Species", "Region", "Island", "Sex")])
#'
#' @export
#'
#' @returns A distance matrix for the categorical variables between two data sets.

chardist <- function(dfa,dfb){
  cl <- match.call()

  name_dfa <- deparse(cl$dfa)
  name_dfb <- deparse(cl$dfb)

  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) || all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  charA <- a[sapply(a,is.numeric)==F]
  charB <- b[sapply(b,is.numeric)==F]

#  charA <- charA[,-c(sapply(charA,function(col) all(length(unique(col))==1)))]

  index <- expand.grid(1:length(charA),1:length(charB))
  # score <- function(index,catA,catB){
  #   d <- numdist(data.frame(model.matrix(~catA[,index[1]]-1, data = catA)),
  #                 data.frame(model.matrix(~catB[,index[2]]-1, data = catB)))
  #   rownames(d) <- sort(unique(catA[,index[1]]))
  #   colnames(d) <- sort(unique(catB[,index[2]]))
  #   dscore(d)$score
  # }
  # result <- apply(index,1,score,catA=charA,catB=charB)
  result <- apply(index,1, function(x) {
    chardist_XY(charA[,x[1]], charB[,x[2]])$distmat$score
  })
#browser()
  matrix(, nrow=ncol(charA),
         dimnames = list(colnames(charA), colnames(charB)))
}
