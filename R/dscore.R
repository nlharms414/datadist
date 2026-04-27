#' @name dscore
#' @title Generates distance score for a distance matrix.
#'
#' @description
#' Computes a distance matrix and distance (similarity) score for the numerical
#' or categorical variables of two data frames.
#'
#'
#' @param dfa Data frame A to compare to `dfb`
#' @param dfb Data frame B to compare to `dfa`
#'
#' @examples
#' dscore(numdist(dataA, dataB))
#'
#' @export
#' @returns A list containing a dataframe with variable mappings & distances and
#' an overall dataframe distance score.

dscore <- function(dmat){
  returns <- list(distmat=NA, mappings=NA, score=NA, extracols=NA)

  mins <- which(dmat==min(dmat), arr.ind = TRUE)
  indices <- data.frame(r = mins[1,1], c = mins[1,2],
                        dist = dmat[mins[1,1],mins[1,2]])
  r <- c(mins[1,1])
  c <- c(mins[1,2])

  repeat {
    mins <- apply(dmat[-r,-c,drop=FALSE],1,min) # find mins
    red <- which(dmat==min(apply(dmat[-r,-c,drop=FALSE],1,min)), arr.ind = TRUE) # remove first row/col of mins (if more than one are the same)
    red <- subset(red,!(red[,2]%in%c) & !(red[,1]%in%r))
    r <- append(r,c(red[1,1]))
    c <- append(c,c(red[1,2]))
    indices <- rbind(indices,c(red[1,],dmat[red[1,1],red[1,2]]))

    if (nrow(dmat[-r, ,drop=FALSE])==0 || ncol(dmat[,-c,drop=FALSE])==0){
      if (nrow(dmat)!=ncol(dmat)) {
        if (nrow(dmat[-r, ,drop=FALSE])>ncol(dmat[,-c,drop=FALSE])) {
          extra <- rownames(dmat)[-r]
        } else{extra <- colnames(dmat)[-c]}
        returns[[4]] <- extra
        warning("Rows and columns not equal. Best matches found.")
        break
      } else {break}
    }
  }

  indices$r <- rownames(dmat)[indices$r]
  indices$c <- colnames(dmat)[indices$c]
  returns[1:3] <- list(dmat,indices,sum(indices$dist))

  returns
}
