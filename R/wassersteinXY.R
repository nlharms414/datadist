#' Calculate the Wasserstein distance between two random variables
#'
#' The Wasserstein distance between two numeric variables X and Y is defined
#' as the distance between their distribution functions $F_X$ and $F_Y$ measured
#' in the p-norm.
#' @param X a real-valued random variable
#' @param Y a real-valued random variable
#' @param scale binary value indicating whether variables are to be normalized
#' @param p non-negative value identifying the norm. $p$ = 1 is Manhattan norm, $p=2$ is Euclidean distance.
#' @param knots non negative integer value specifying the number of evaluations within the ranges of X and Y.
#' @importFrom stats ecdf
#' @returns single positive value. Larger values indicate less similarity.
#' @export
#' @examples
#'
#' x <- runif(1000)
#' y <- runif(500)
#' wassersteinXY(x, y, knots=50)
#' wassersteinXY(x, y, scale=TRUE, knots=50)
#' # compare to results from transport::wasserstein1d(x, y)

wassersteinXY <- function(X, Y, scale=FALSE,  p = 1, knots=max(c(length(X), length(Y)))) {
  # if either X or Y is not numeric, return an NA for now
  # Inf might also work
  if (!is.numeric(X)) return(NA)
  if (!is.numeric(Y)) return(NA)

  if (scale) {
    X <- scale(X)
    Y <- scale(Y)
  }

  # estimate the distribution functions
  FX <- ecdf(X)
  FY <- ecdf(Y)
  pnorm <- function(t) {
    mean(abs(FX(t) - FY(t))^p)^(1/p)
  }

  limits <- range(c(X, Y), na.rm=TRUE)
  ts <- seq(from=limits[1], to=limits[2], length.out=knots)
  #  browser()
  #  philentropy::minkowski(FX(ts), FY(ts), n=1)/knots
  pnorm(ts)
}
