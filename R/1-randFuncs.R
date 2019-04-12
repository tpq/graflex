#' Make Random Graph
#'
#' This function makes a random graph.
#'
#' @param size An integer. The size of the graph.
#' @return An adjacency matrix.
#' @export
randGraph <- function(size){

  A <- matrix(sample(c(0, 1), size^2, replace = TRUE), size, size)
  diag(A) <- 0
  sym(A)
}

#' Make Random Concept Graph
#'
#' This function makes a random concept graph, defined here
#'  as a fully connected sub-graph.
#'
#' @inheritParams randGraph
#' @param fill An integer. The number of nodes to connect.
#' @return An adjacency matrix.
#' @export
randConcept <- function(size, fill = .5*size){

  if(fill > size) stop("Please provide 'fill' smallers than 'size'.")

  g <- vector("numeric", size)
  index <- sample(1:length(g), fill)
  g[index] <- 1
  g %*% t(g)
}

#' Make Random Matrix
#'
#' This function makes a random matrix by sampling
#'  rows from a Poisson distribution.
#'
#' @param nrows An integer. The number of rows in the matrix.
#' @param ncols An integer. The number of columns in the matrix.
#' @param lambda Argument passed to \code{rpois}.
#' @return A matrix.
#' @export
randPois <- function(nrows, ncols = nrows, lambda = 100){

  counts <- stats::rpois(nrows*ncols, lambda = lambda)
  matrix(counts, nrows, ncols)
}

#' Make Random Propd Graph
#'
#' This function builds a graph based on a \code{propr::propd}
#'  analysis of a random Poisson matrix.
#'
#' @inheritParams randGraph
#' @return An adjacency matrix.
#' @export
randPropd <- function(size){

  packageCheck("propr")

  dat <- randPois(size)
  pd <- suppressMessages(
    propr::propd(dat, sample(c("A", "B"), replace = TRUE, size = size))
  )
  pd <- suppressMessages(
    propr::updateF(pd)
  )

  cutoff <- propr::qtheta(pd, pval = .05)
  A <- propr::getAdj(pd, cutoff = cutoff)
  A
}

#' Make Random Knowledge Database
#'
#' This function builds a knowledge database with nodes
#'  as rows and concepts as columns.
#'
#' @param nnodes The number of nodes (rows).
#' @param nconcepts The number of concepts (columns).
#' @inheritParams randConcept
#' @return A knowledge database where each row is a graph node
#'  and each column is a concept.
#' @export
randK <- function(nnodes, nconcepts, fill = .5*nnodes){

  K <- matrix(0, nnodes, nconcepts)
  K <- apply(K, 2, function(concept){
    index <- sample(1:length(concept), fill)
    concept[index] <- 1
    concept
  })
  K
}
