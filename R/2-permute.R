#' Permute Odds Ratio
#'
#' This function permutes \code{p} odds ratios for the
#'  edge overlap between two non-random graphs.
#'  It does this by randomly shuffling the rows and
#'  columns of \code{A} (jointly, thus preserving
#'  the degree distribution).
#'
#' Note that this function calculates overlap for the
#'  lower-left triangle of the input matrices.
#'
#' @param A,G An adjacency matrix.
#' @param p An integer. The number of overlaps to permute.
#' @export
permuteOR <- function(A, G, p = 500){

  Gstar <- G[lower.tri(G)]
  res <- lapply(1:p, function(i){

    # Shuffle the adjacency matrix
    index <- sample(1:ncol(A))
    A <- A[index, index]
    Astar <- A[lower.tri(A)]
    getOR(Astar, Gstar)
  })

  do.call("rbind", res)
}

#' Calculate Odds Ratio
#'
#' This function calculates an odds ratio for the
#'  edge overlap between two non-random graphs.
#'
#' Note that this function calculates overlap for the
#'  lower-left triangle of the input matrices.
#'
#' @inheritParams permuteOR
#' @export
calculateOR <- function(A, G){

  Astar <- A[lower.tri(A)]
  Gstar <- G[lower.tri(G)]
  getOR(Astar, Gstar)
}

#' Calculate Odds Ratio FDR
#'
#' This function calculates the false discovery rate (FDR)
#'  for over- and under-enrichment by counting the number of
#'  times the actual OR was greater than
#'  (or less than) a permuted OR.
#'  Used by \code{\link{graflex}}.
#'
#' @param actual A result from \code{\link{calculateOR}}.
#' @param permuted A result from \code{\link{permuteOR}}.
#' @return A \code{data.frame} of the FDRs for over-
#'  and under- enrichment.
#' @export
getFDR <- function(actual, permuted){

  actual$FDR.under <- sum(permuted$Odds <= actual$Odds) / nrow(permuted)
  actual$FDR.over <- sum(permuted$Odds >= actual$Odds) / nrow(permuted)
  actual
}
