#' @name numdist
#' @title Difference measure for numerical columns between two data sets.
#'
#' @description
#' Produces a numerical variable distance matrix between two data sets. Dates will
#' be coerced into a numerical format via `as.numeric`.
#'
#' @param dfa data set A
#' @param dfb data set B
#'
#' @returns A distance matrix created using `wassersteinXY()` on every pairwise combination
#' of numerical variables between data set A and data set B.
#'
#' @examples
#' # example code
#' dataA <- data.frame(a = c(1,5,3,2),
#'                     b = c(4,1,6,8),
#'                     c = c(3,6,1,7),
#'                     d = c("orange","apple","mango","apple"),
#'                     e = c("one","three","two","one"))
#' dataB <- data.frame(f = c(4,1,6,8),
#'                     g = c(1,5,3,2),
#'                     h = c(3,6,1,7),
#'                     i = c("one","three","two","one"),
#'                     j = c(5,6,0,9),
#'                     k = c("orange","apple","mango","apple"))
#'
#' numdist(dataA, dataB)
#'
#' numdist(penguins,penguins_raw)
#'
#' @export
#' @importFrom lubridate is.Date

numdist <- function(dfa,dfb){
  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) || all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  # browser()

  numA <- a[sapply(a,is.numeric)]
  numB <- b[sapply(b,is.numeric)]

  if(length(which(sapply(a,function(col) lubridate::is.Date(col))))!=0) {
    numA <- sapply(a[c(which(sapply(a,is.numeric)),which(sapply(a,lubridate::is.Date)))],
                   as.numeric)
  }

  if(length(which(sapply(b,function(col) lubridate::is.Date(col))))!=0) {
    numB <- sapply(b[c(which(sapply(b,is.numeric)),which(sapply(b,lubridate::is.Date)))],
                   as.numeric)
  }

  index <- expand.grid(1:ncol(numA),1:ncol(numB))

  distance <- function(index,x,y){
    wassersteinXY(x[,index[1]],y[,index[2]])
  }

  result <- apply(index,1,distance,x=numA,y=numB)
  dmat <- matrix(result, nrow=ncol(numA),
         dimnames = list(colnames(numA), colnames(numB)))

  list(dmat = dmat, distscore = suppressWarnings(dscore(dmat)$distscore))
}

