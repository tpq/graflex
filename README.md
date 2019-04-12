
<!-- README.md is generated from README.Rmd. Please edit that file -->
Quick start
-----------

Welcome to the `graflex` GitHub page!

The Fisher's Exact Test is often used to measure the significance of overlap between two categorical variables. However, the test operates on the assumption that the relationship between observations is independent. Depending on how a graph is made, this assumption may not hold, thus making the Fisher's Exact Test invalid. This package offers a fast way to permute a false discovery rate (FDR) for the edge overlap between two non-random graphs using an odds ratio (OR) test statistic.

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
#> 1      15      5     20    5 0.7500000 -0.2876821     0.456    0.790
#> 2      15      5     20    5 0.7500000 -0.2876821     0.468    0.778
#> 3      14      6     21    4 0.4444444 -0.8109302     0.260    0.886
#>   Permutes
#> 1      500
#> 2      500
#> 3      500
```
