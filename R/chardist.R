#' @name chardist
#' @title Generates distance matrix for categorical columns in two data sets.
#'
#' @description
#' Computes a distance matrix and distance (similarity) score for the categorical
#' columns in two data sets. Can compute a distance matrix between the categories
#' of two individual categorical variables.
#'
#' @param dfa data set A or variable A to compare to data set B or variable
#' B (`dfb`).
#' @param dfb data set B  or variable B to compare to data set A or variable
#' A (`dfa`).
#'
#' @returns A distance matrix for the categorical variables between two data
#' sets, plus the distance score.
#'
#' @examples
#' chardist(penguins,penguins_raw)
#'
#' @export
#' @importFrom stats model.matrix
#' @importFrom lubridate is.Date


chardist <- function(dfa,dfb){
  # cl <- match.call()
  #
  # name_dfa <- deparse(cl$dfa)
  # name_dfb <- deparse(cl$dfb)

  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) || all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  # browser()

  returns <- NA

  if(length(a)==1 && length(b)==1){
    dmat <- numdist(data.frame(model.matrix(~a[,1]-1,data=a)),
                    data.frame(model.matrix(~b[,1]-1,data=b)))$dmat
    rownames(dmat) <- sort(unique(a[,1]))
    colnames(dmat) <- sort(unique(b[,1]))
    return(dmat)
  }
  charA <- a[sapply(a,is.numeric)==F]
  charB <- b[sapply(b,is.numeric)==F]

  # browser()

  # remove categorical columns with only one category
  if(length(which(sapply(charA,function(col) all(length(unique(col))==1))))!=0) {
    charA <- charA[,-c(which(sapply(charA,function(col) all(length(unique(col))==1))))]
  }

  if(length(which(sapply(charB,function(col) all(length(unique(col))==1))))!=0) {
    charB <- charB[,-c(which(sapply(charB,function(col) all(length(unique(col))==1))))]
  }

  # remove date columns
  if(length(which(sapply(charA,lubridate::is.Date)))!=0) {
    charA <- charA[,-c(which(sapply(charA,lubridate::is.Date)))]
  }

  if(length(which(sapply(charB,lubridate::is.Date)))!=0) {
    charB <- charB[,-c(which(sapply(charB,lubridate::is.Date)))]
  }

  index <- expand.grid(1:length(charA),1:length(charB))

  score <- function(index,catA,catB){
    d <- numdist(data.frame(model.matrix(~catA[,index[1]]-1, data = catA)),
                  data.frame(model.matrix(~catB[,index[2]]-1, data = catB)))$dmat
    suppressWarnings(dscore(d)$distscore)
  }
# browser()
  result <- apply(index,1,score,catA=charA,catB=charB)
  returns <- matrix(result, nrow=ncol(charA),
                    dimnames = list(colnames(charA), colnames(charB)))
  returns

#   charA <- a[sapply(a,is.numeric)==F]
#   charB <- b[sapply(b,is.numeric)==F]
#
# #  charA <- charA[,-c(sapply(charA,function(col) all(length(unique(col))==1)))]
#
#   index <- expand.grid(1:length(charA),1:length(charB))
#   # score <- function(index,catA,catB){
#   #   d <- numdist(data.frame(model.matrix(~catA[,index[1]]-1, data = catA)),
#   #                 data.frame(model.matrix(~catB[,index[2]]-1, data = catB)))
#   #   rownames(d) <- sort(unique(catA[,index[1]]))
#   #   colnames(d) <- sort(unique(catB[,index[2]]))
#   #   dscore(d)$score
#   # }
#   # result <- apply(index,1,score,catA=charA,catB=charB)
#   result <- apply(index,1, function(x) {
#     chardist_XY(charA[,x[1]], charB[,x[2]])$distmat$score
#   })
# #browser()
#   matrix(, nrow=ncol(charA),
#          dimnames = list(colnames(charA), colnames(charB)))

}

