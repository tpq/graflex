library(graflex)

set.seed(1)
A <- randGraph(50)
B <- randConcept(50)

test_that("", {

  a <- calculateOR(A, B)
  o <- permuteOR(A, B)
  fdr <- getFDR(a, o)

  expect_gte(
    fdr$FDR.under,
    .05
  )

  expect_gte(
    fdr$FDR.over,
    .05
  )
})
