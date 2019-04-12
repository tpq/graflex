
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
set.seed(1)
A <- randGraph(100) # a graph of interest
K <- randK(100, 3) # a database relating nodes (rows) to concepts (cols)
graflex(A, K) # permute FDR for overlap
#> |------------(25%)----------(50%)----------(75%)----------|
#>   Neither G.only A.only Both      Odds       LogOR FDR.under FDR.over
#> 1    1887    611   1838  614 1.0317003  0.03120821     0.664    0.354
#> 2    1870    628   1855  597 0.9583240 -0.04256932     0.260    0.762
#> 3    1864    634   1861  591 0.9336794 -0.06862220     0.166    0.844
#>   Permutes
#> 1      500
#> 2      500
#> 3      500
```
