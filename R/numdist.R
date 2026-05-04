#' @name numdist
#' @title Difference measure for numerical columns between two data sets.
#'
#' @description
#' Produces a numerical variable distance matrix between two data sets. Dates will
#' be coerced into a numerical format via `as.numeric`.
#'
#' @param dfa data set A
#' @param dfb data set B
#' @param scale binary option to set the scale option in `wassersteinXY()` to
#' TRUE, so variables are scaled before computing distance. Default is FALSE.
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
#' numdist(penguins,penguins_raw, scale=TRUE)
#'
#' @export
#' @importFrom lubridate is.Date

numdist <- function(dfa, dfb, scale=FALSE){
  cl <- match.call()

  name_dfa <- deparse(cl$dfa)
  name_dfb <- deparse(cl$dfb)

  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) || all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  # browser()

  numA <- date_cols(a[sapply(a,is.numeric)],a,add=T)
  numB <- date_cols(b[sapply(b,is.numeric)],b,add=T)

  numdist <- matrix(NA,nrow = ncol(numA),ncol = ncol(numB))
  attr(numdist, "dfa") <- name_dfa
  attr(numdist, "dfb") <- name_dfb

  if (ncol(numA)>0 || ncol(numB)>0) {
    if (scale) {
      for (i in 1:ncol(numA)) {
        for (j in 1:ncol(numB)) {
          numdist[i,j] <- wassersteinXY(numA[,i],numB[,j], scale = TRUE)
        }
      }
    } else{
      for (i in 1:ncol(numA)) {
        for (j in 1:ncol(numB)) {
          numdist[i,j] <- wassersteinXY(numA[,i],numB[,j])
        }
      }
    }
    colnames(numdist) <- colnames(numB)
    rownames(numdist) <- colnames(numA)
  }
  numdist

}

