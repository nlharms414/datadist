# test function for data distance function

#' @name test
#' @title Test
#'
#' @description
#' Test function for data distance function... more to come :)
#'
#' @returns A list of objects.
#' @export
#' @examples
#' # example code
#' test(data1,data2)

library(transport)

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
      matrix[i,j] <- wasserstein1d(numA[,i],numB[,j])
    }
  }


  return(list(dist = matrix, "char A" = charA, "char B" = charB))
}


