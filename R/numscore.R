# Distance score function

#' @name numscore
#' @title Generates distance score
#'
#' @description
#' Computes a distance matrix and distance (similarity) score for two data frames.
#'
#' @param dfa Data frame A to compare to `dfb`
#' @param dfb Data frame B to compare to `dfa`
#'
#' @examples
#' # example code
#'
#' @export
#' @returns A list containing a dataframe with variable mappings & distances and
#' an overall dataframe distance score.

numscore <- function(dfa,dfb){
  a <- as.data.frame(dfa[])  # convert to data.frames if not
  b <- as.data.frame(dfb[])
  if(all((class(a)=="data.frame")==F) | all((class(b)=="data.frame")==F)){
    stop("Could not convert to data.frame.")
  }

  numA <- a[sapply(a,is.numeric)]
  numB <- b[sapply(b,is.numeric)]

  dmat <- matrix(NA,nrow = ncol(numA),ncol = ncol(numB))

  for (i in 1:ncol(numA)) {
    for (j in 1:ncol(numB)) {
     dmat[i,j] <- wassersteinXY(numA[,i],numB[,j])
    }
  }

  colnames(dmat) <- colnames(numB)
  rownames(dmat) <- colnames(numA)

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

    if (nrow(dmat[-r, ,drop=FALSE])==0 || ncol(dmat[,-c,drop=FALSE])==0){
      if (nrow(dmat)!=ncol(dmat)) {
        if (nrow(dmat[-r, ,drop=FALSE])>ncol(dmat[,-c,drop=FALSE])) {
          extra <- rownames(dmat)[-r]
        } else{extra <- colnames(dmat)[-c]}
        warning("Rows and columns not equal. Best matches found.")
        break
      } else {break}
    }
  }

  indices$r <- rownames(dmat)[indices$r]
  indices$c <- colnames(dmat)[indices$c]

  return(list(distmat=dmat, mappings = indices, score = sum(indices$dist), extracols = extra))
}

# add examples
