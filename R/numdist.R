# test function for data distance function

#' @name numdist
#' @title Difference Measure for Data Sets
#'
#' @description
#' Produces a numerical variable distance matrix between two data sets.
#'
#' @param dfa data.frame
#' @param dfb data.frame
#' @returns `numdist` is returned using the `wassersteinXY()` function to compute a
#' distance matrix for every numerical variable combination between data frame A
#' and data frame B.
#'
#' @export
#' @examples
#' # example code
#' dataA <- data.frame(a = c(1,5,3,2),
#'                     b = c(4,1,6,8),
#'                     c = c(3,6,1,7),
#'                     d = c("apple","orange","banana","mango"))
#' dataB <- data.frame(a = c(1,9,2,6),
#'                     b = c(4,2,6,9),
#'                     c = c(3,6,1,7),
#'                     d = c(3,7,9,2),
#'                     e = c("pear","grape","lemon","lime"))
#' numdist(dataA, dataB)

numdist <- function(dfa,dfb){
  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) || all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  numA <- a[sapply(a,is.numeric)]
  numB <- b[sapply(b,is.numeric)]

  numdist <- matrix(NA,nrow = ncol(numA),ncol = ncol(numB))

  if (ncol(numA)>0 || ncol(numB)>0) {
    for (i in 1:ncol(numA)) {
      for (j in 1:ncol(numB)) {
        numdist[i,j] <- wassersteinXY(numA[,i],numB[,j])
      }
    }
    colnames(numdist) <- colnames(numB)
    rownames(numdist) <- colnames(numA)
  }

  numdist
}

# get rid of for loop somehow?
