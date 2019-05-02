context("Test checkers")


test_that("check_prob", {
  expect_true(check_prob(0.1))
  expect_length(check_prob(0.1), 1)
  expect_error(check_prob(-0.1), 'invalid prob value')
  expect_error(check_prob(1.1), 'invalid prob value')
  expect_type(check_prob(0.5), 'logical')
})


test_that("check_trials", {
  expect_true(check_trials(0))
  expect_true(check_trials(1))
  expect_true(check_trials(1000))
  expect_error(check_trials(-1), 'invalid trials value')
  expect_error(check_trials(2.5), 'invalid trials value')
  expect_type(check_trials(5), 'logical')
})


test_that("check_success", {
  expect_true(check_success(c(1, 2, 3), 4))
  expect_error(check_success(c(1, 2, -3), 4), 'invalid success value')
  expect_error(check_success(c(1, 2, 5), 4), 'invalid success value')
  expect_error(check_success(c(1, 2, 3.5), 4), 'invalid success value')
  expect_type(check_success(c(1, 2, 3), 4), 'logical')
})


