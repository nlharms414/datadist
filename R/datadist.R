# test function for data distance function

#' @name datadist
#' @title Difference Measure for Data Sets
#'
#' @description
#' Produces a numerical variable distance matrix and a categorical variable
#' distance matrix.
#'
#' @param dfa data.frame
#' @param dfb data.frame
#' @returns `numdist` is returned using the `wassersteinXY()` function to find a
#' distance matrix for every numerical variable combination between data frame A
#' and data frame B. `chardist` is found likewise.
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
#' datadist(dataA, dataB)

datadist <- function(dfa,dfb){
  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) | all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  numA <- a[sapply(a,is.numeric)]
  numB <- b[sapply(b,is.numeric)]
  charA <- a[sapply(a,is.numeric)==F]
  charB <- b[sapply(b,is.numeric)==F]

  nummat <- matrix(NA,nrow = ncol(numA),ncol = ncol(numB))
  charmat <- matrix(NA,nrow = ncol(charA),ncol = ncol(charB))

  for (i in 1:ncol(numA)) {
    for (j in 1:ncol(numB)) {
      nummat[i,j] <- wassersteinXY(numA[,i],numB[,j])
    }
  }

  for (i in 1:ncol(charA)) {
    for (j in 1:ncol(charB)) {
      charmat[i,j] <- wassersteinXY(table(charA[,i]),table(charB[,j]))
    }
  }

  colnames(nummat) <- colnames(numB)
  rownames(nummat) <- colnames(numA)
  colnames(charmat) <- colnames(charB)
  rownames(charmat) <- colnames(charA)

  return(list(numdist = nummat, chardist = charmat))
}




# for char variables order each variable by factor density
# do them by natural factor order as well
# if already a factor just leave it
# create second variable that's sorted by size
# package stringdist
# package fuzzy in r (jk it does not exist)


