library(graflex)

A <- sample(0:1, size = 500, replace = TRUE)
B <- sample(0:1, size = 500, replace = TRUE)

test_that("binTab and table agree", {

  expect_equal(
    matrix(table(A, B), 2, 2),
    binTab(A, B)
  )
})
