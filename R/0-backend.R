#' Symmetrize Matrix
#'
#' This function makes a square matrix symmetric.
#'
#' @param A An adjacency matrix.
#' @return An adjacency matrix.
#' @export
sym <- function(A){

  if(nrow(A) != ncol(A)) stop("Please provide a square matrix.")

  fill <- A[lower.tri(A)]
  A <- t(A)
  A[lower.tri(A)] <- fill
  A
}

#' Tabulate Overlap
#'
#' This function tabulates the overlap between
#'  two vectors or two adjacency matrices.
#'  It is a faster version of \code{table} that
#'  only supports binary input.
#'
#' @param A,G A vector or adjacency matrix.
#' @return A table of overlap.
#' @export
binTab <- function(A, G){

  diff <- A != G
  only1 <- A[diff]
  b <- sum(only1)
  c <- length(only1) - b

  same <- !diff
  double1 <- A[same]
  a <- sum(double1)
  d <- length(double1) - a

  matrix(c(d, b, c, a), 2, 2)
}

#' Calculate Odds Ratio
#'
#' This function calculates the overlap between
#'  two vectors or two adjacency matrices.
#'  It returns the OR as well as other metrics.
#'
#' @inheritParams binTab
#' @return A \code{data.frame} of results.
#' @export
getOR <- function(A, G){

  tab <- binTab(A, G)
  or <- (tab[1,1] * tab[2,2]) / (tab[1,2] * tab[2,1])
  data.frame(
    "Neither" = tab[1,1],
    "G.only" = tab[1,2],
    "A.only" = tab[2,1],
    "Both" = tab[2,2],
    "Odds" = or,
    "LogOR" = log(or)
  )
}

#' Make Progress Bar
#'
#' @param i The current iteration.
#' @param k Total iterations.
#' @param numTicks The result of \code{progress}.
#' @return The next \code{numTicks} argument.
progress <- function(i, k, numTicks){

  if(i == 1) numTicks <- 0

  if(numTicks == 0) cat("|-")

  while(i > numTicks*(k/40)){

    cat("-")
    if(numTicks == 10) cat("(25%)")
    if(numTicks == 20) cat("(50%)")
    if(numTicks == 30) cat("(75%)")
    numTicks <- numTicks + 1
  }

  if(i == k) cat("-|\n")

  return(numTicks)
}

#' Package Check
#'
#' Checks whether the user has the required package installed.
#'  For back-end use only.
#'
#' @param package A character string. An R package.
packageCheck <- function(package){

  if(!requireNamespace(package, quietly = TRUE)){
    stop("Uh oh! This graflex method depends on ", package, "! ",
         "Try running: install.packages('", package, "')")
  }
}
