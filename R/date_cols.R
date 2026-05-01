#' @name date_cols
#' @title Adds or removes date columns from a data frame.
#'
#' @description A function that will add date columns to a specified data frame
#' or remove them, based on user specification. Designed as a helper function
#' for numdist() and chardist().
#'
#' @param dfA data frame to add date columns to or remove date columns from.
#' @param dfB optional second data frame to extract date columns from to be added
#' to dfA. Default is NA.
#' @param add binary operator to add or remove date column(s), where TRUE adds
#' the columns. Default is TRUE.
#'
#' @returns A data frame with dates either added or removed, based on user
#' specification.
#'
#' @examples
#' # example code
#'
#'
#' @export
#' @importFrom lubridate is.Date

date_cols <- function(dfA, dfB=NA, add = TRUE){

  which_dates <- function(df) names(df)[sapply(df, lubridate::is.Date)]

  if(add == TRUE){
    if(length(which_dates(dfB))!=0) {
      return(cbind(dfA, dfB[,which_dates(dfB), drop=F]))
    } else {
      return(dfA)
    }
  }

  if(add == FALSE){
    if(length(which_dates(dfA))!=0) {
      return(dfA[, !names(dfA) %in% which_dates(dfA), drop=F])
    } else {
      return(dfA)
    }
  }

}

