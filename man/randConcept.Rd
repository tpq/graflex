% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/1-randFuncs.R
\name{randConcept}
\alias{randConcept}
\title{Make Random Concept Graph}
\usage{
randConcept(size, fill = 0.5 * size)
}
\arguments{
\item{size}{An integer. The size of the graph.}

\item{fill}{An integer. The number of nodes to connect.}
}
\value{
An adjacency matrix.
}
\description{
This function makes a random concept graph, defined here
 as a fully connected sub-graph.
}
