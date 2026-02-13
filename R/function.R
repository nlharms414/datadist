# test function for data distance function

#' @name test
#' @title Test
#'
#' @description
#' Test function for data distance function... more to come :)
#'
#' @param a data.frame
#' @param b data.frame
#' @returns A list of objects.
#' @importFrom transport wasserstein1d
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
#' test(dataA, dataB)
test <- function(a,b){
  a <- as.data.frame(a[])  # convert to dataframes if not
  b <- as.data.frame(b[])
  numA <- a[sapply(a,is.numeric)]
  numB <- b[sapply(b,is.numeric)]
  charA <- a[sapply(a,is.numeric)==F]
  charB <- b[sapply(b,is.numeric)==F]

  # add in stop if criteria aren't met

  matrix <- matrix(NA,nrow = ncol(numA),ncol = ncol(numB))

  for (i in 1:ncol(numA)) {
    for (j in 1:ncol(numB)) {
      matrix[i,j] <- transport::wasserstein1d(numA[,i],numB[,j])
    }
  }


  return(list(dist = matrix, "char A" = charA, "char B" = charB))
}


