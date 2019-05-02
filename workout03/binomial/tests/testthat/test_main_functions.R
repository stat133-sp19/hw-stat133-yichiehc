context("Test binomial")


test_that("bin_choose", {
  expect_equal(bin_choose(5, 2), 10)
  expect_equal(bin_choose(5, 1:4), c(5, 10, 10, 5))
  expect_length(bin_choose(5, 1:4), 4)
  expect_error(bin_choose(5, 6), "k can not be greater than n")
})


test_that("bin_probability", {
  expect_error(bin_probability(2, -1, 0.5))
  expect_error(bin_probability(2, 3, 1.5))
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_length(bin_probability(success = 0:2, trials = 5, prob = 0.5), 3)
})


test_that("bin_distribution",{
  expect_is(bin_distribution(trials = 5, prob = 0.5), c('bindis', 'data.frame'))
  expect_length(bin_distribution(trials = 5, prob = 0.5), 2)
  expect_length(bin_distribution(trials = 5, prob = 0.5)[[1]], 6)
  expect_equal(bin_distribution(trials = 5, prob = 0.5)[[2]][1], 0.03125)
})


test_that("bin_cumulative", {
  expect_is(bin_cumulative(trials = 5, prob = 0.5), c('bincum', 'data.frame'))
  expect_length(bin_cumulative(trials = 5, prob = 0.5), 3)
  expect_length(bin_cumulative(trials = 5, prob = 0.5)[[1]], 6)
  expect_equal(bin_cumulative(trials = 5, prob = 0.5)[[2]][1], bin_cumulative(trials = 5, prob = 0.5)[[3]][1])
  expect_equal(bin_cumulative(trials = 5, prob = 0.5)[[3]][2], 0.18750)
})


