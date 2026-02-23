# test function for data distance function

#' @name datadist
#' @title Difference Measure for Data Sets
#'
#' @description
#' Test function for data distance function... more to come :)
#'
#' @param a data.frame
#' @param b data.frame
#' @returns A list of objects.
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
#' datadist(dataA, dataB)
datadist <- function(a,b){
  a <- as.data.frame(a[])  # convert to data.frames if not
  b <- as.data.frame(b[])
  if(all((class(a)=="data.frame")==F) | all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  # some way to make things more concise here...
  numA <- a[sapply(a,is.numeric)]
  numB <- b[sapply(b,is.numeric)]
  charA <- a[sapply(a,is.numeric)==F]
  charB <- b[sapply(b,is.numeric)==F]

  namesA <- colnames(numA)
  namesB <- colnames(numB)

  # add in stop if criteria aren't met

  matrix <- matrix(NA,nrow = ncol(numA),ncol = ncol(numB))

  for (i in 1:ncol(numA)) {
    for (j in 1:ncol(numB)) {
      matrix[i,j] <- wassersteinXY(numA[,i],numB[,j])
    }
  }

  colnames(matrix) <- namesB
  rownames(matrix) <- namesA

  return(list(dist = matrix, "char A" = charA, "char B" = charB,
              score = sum(dplyr::near(apply(matrix,1,FUN = min),0))))
  # could change tolerance
}


