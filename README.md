
<!-- README.md is generated from README.Rmd. Please edit that file -->
Quick start
-----------

Welcome to the `graflex` GitHub page!

The Fisher's Exact Test is often used to measure the significance of overlap between two categorical variables. However, the test operates on the assumption that the relationship between observations is independent. Depending on how a graph is made, this assumption may not hold, thus making the Fisher's Exact Test invalid. This package offers a fast way to permute a false discovery rate (FDR) for the edge overlap between two non-random graphs, using the odds ratio (OR) as the test statistic.

``` r
library(devtools)
devtools::install_github("tpq/graflex")
```

``` r
library(graflex)
A <- randGraph(10) # a graph of interest
K <- randK(10, 3) # a database related nodes (rows) to concepts (cols)
graflex(A, K) # permute FDR for overlap
#> |------------(25%)----------(50%)----------(75%)----------|
#>   Neither G.only A.only Both      Odds      LogOR FDR.under FDR.over
#> 1      14      7     21    3 0.2857143 -1.2527630     0.052    0.992
#> 2      15      6     20    4 0.5000000 -0.6931472     0.232    0.934
#> 3      17      4     18    6 1.4166667  0.3483067     0.874    0.490
#>   Permutes
#> 1      500
#> 2      500
#> 3      500
```
