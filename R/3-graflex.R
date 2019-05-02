#' Build Knowledge Database for Human Genes
#'
#' This helper function wraps the few steps needed
#'  to make a "knowledge database" used by \code{\link{graflex}}.
#'
#' A knowledge database contains a row (g) for each node in the graph,
#'  and a column (c) for each concept tested for enrichment.
#'  \code{K_{gc} = 1} whenever a node associates with a concept.
#'
#' @param keys A character vector. The IDs for the genes to map.
#'  Argument passed to \code{AnnotationDbi::select}.
#' @param columns A string. The concepts to return (e.g., GO).
#'  Argument passed to \code{AnnotationDbi::select}.
#' @param keytype A string. The type of IDs being mapped.
#'  Argument passed to \code{AnnotationDbi::select}.
#' @param minK An integer. The minimum number of nodes to which
#'  a concept maps to be included in final table.
#'  Skip with \code{minK = 0}.
#' @return A knowledge database where each row is a graph node
#'  and each column is a concept.
#' @export
getK <- function(keys, columns = "GO", keytype = "ENSEMBL", minK = 10){

  if(length(columns) > 1) stop("Please provide a single column.")

  packageCheck("AnnotationDbi")
  packageCheck("org.Hs.eg.db")

  # Build K knowledge database from GO
  db <- org.Hs.eg.db::org.Hs.eg.db
  godf <- AnnotationDbi::select(db, keys = keys, columns = columns, keytype = keytype)
  gotab <- table(godf[,1:2]) # handles NAs!!
  gotab[gotab > 1] <- 1

  # Sort and filter K database
  gotab <- gotab[keys, ]
  if(!identical(rownames(gotab), keys)){
    stop("Uh oh! Unexpected mapping.")
  }
  gotab[,colSums(gotab) >= minK]
}

#' Permute FDR for Multiple Concepts
#'
#' This function calls \code{\link{permuteOR}} for each
#'  concept (i.e., column) in the database \code{K}.
#'  See \code{\link{getK}} for more information.
#'
#' For each concept, this function calculates the
#'  false discovery rate (FDR) by counting the number of
#'  times the actual OR was greater than
#'  (or less than) a permuted OR.
#'
#' @inheritParams permuteOR
#' @param A An adjacency matrix.
#' @param K A knowledge database where each row is a graph node
#'  and each column is a concept.
#' @export
graflex <- function(A, K, p = 500){

  if(nrow(A) != nrow(K)) stop("'A' and 'K' must have identical rows.")

  numTicks <- 0
  res <- lapply(1:ncol(K), function(k){

    numTicks <<- progress(k, ncol(K), numTicks)
    Gk <- K[,k] %*% t(K[,k])
    actual <- calculateOR(A, Gk)
    permuted <- permuteOR(A, Gk, p = p)
    actual <- getFDR(actual, permuted)
    actual$Permutes <- p
    actual$Concept <- colnames(K)[k]
    actual
  })

  do.call("rbind", res)
}
