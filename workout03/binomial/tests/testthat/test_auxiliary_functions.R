context("Test summary measures")


test_that("aux_mean", {
  expect_equal(aux_mean(10, 0.3), 3)
  expect_type(aux_mean(10, 0.3), 'double')
  expect_length(aux_mean(10, 0.3), 1)
})


test_that("aux_variance", {
  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_type(aux_variance(10, 0.3), 'double')
  expect_length(aux_variance(10, 0.3), 1)
})


test_that("aux_mode", {
  expect_equal(aux_mode(10, 0.3), 3)
  expect_type(aux_mode(10, 0.3), 'double')
  expect_length(aux_mode(5, 0.5), 2)
})


test_that('aux_skewness', {
  expect_equal(round(aux_skewness(10, 0.3), 4), 0.2760)
  expect_type(aux_skewness(10, 0.3), 'double')
  expect_length(aux_skewness(10, 0.3), 1)
})


test_that('aux_kurtosis', {
  expect_equal(round(aux_kurtosis(10, 0.3), 4), -0.1238)
  expect_type(aux_kurtosis(10, 0.3), 'double')
  expect_length(aux_kurtosis(10, 0.3), 1)
})


