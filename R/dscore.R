# Distance score function

#' @name dscore
#' @title Generates distance score
#'
#' @description
#' Computes a distance score for two matrices after use of `datadist()`
#'
#' @param dmat Distance matrix derived from use of `datadist()`
#'
#' @examples
#' # example code
#'
#' @returns A list containing a dataframe with variable mappings & distances and
#' an overall dataframe distance score.

dscore <- function(dmat){
  mins <- which(dmat==min(dmat), arr.ind = TRUE)
  indices <- data.frame(r = mins[1,1], c = mins[1,2],
                        dist = dmat[mins[1,1],mins[1,2]])
  r <- c(mins[1,1])
  c <- c(mins[1,2])

  repeat {
    mins <- apply(dmat[-r,-c,drop=FALSE],1,min) # find mins
    red <- which(dmat==min(apply(dmat[-r,-c,drop=FALSE],1,min)), arr.ind = TRUE) # remove first row/col of mins (if more than one are the same)
    red <- subset(red,!(red[,2]%in%c))
    r <- append(r,c(red[1,1]))
    c <- append(c,c(red[1,2]))
    indices <- rbind(indices,c(red[1,],dmat[red[1,1],red[1,2]]))

    if (nrow(dmat[-r, ,drop=FALSE])==0 || ncol(dmat[,-c,drop=FALSE])==0) break
  }

  indices$r <- rownames(dmat)[indices$r]
  indices$c <- colnames(dmat)[indices$c]

  return(list(mappings = indices, score = sum(indices$dist)))
}

