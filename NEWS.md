## graflex 0.0.3
---------------------
* Fix bug where `getK` triggers an error

## graflex 0.0.2
---------------------
* Add tests for `binTab` and `getFDR` functions

## graflex 0.0.1
---------------------
* New backend functions
    * `sym` function makes matrix symmetric
    * `binTab` function provides fast alternative to `table`
    * `getOR` wraps `binTab` to calculate odds ratio
    * `packageCheck` and `progress` not exported
* New random functions
    * `randPois` function makes a random Poisson matrix
    * `randGraph` function makes a random adjacency matrix
    * `randConcept` function makes a random fully connected sub-graph
    * `randPropd` function makes an adjacency matrix from a `propr::propd` analysis
    * `randK` function makes a random knowledge database
* New OR functions
    * `calculateOR` calculates the actual odds ratio (OR)
    * `permuteOR` permutes many odds ratios (OR)
    * `getFDR` calculates FDR based on ORs
* New graflex functions
    * `getK` builds knowledge database for human genes
    * `graflex` calculates FDR for multiple concepts
* New vignette
