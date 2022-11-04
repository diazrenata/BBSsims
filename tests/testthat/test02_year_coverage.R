
test_that("pull years works", {

  a_dataset <- hartland

  dataset_years <- get_years(a_dataset)

  expect_true(min(dataset_years$year) == 1994)
  expect_true(max(dataset_years$year) == 2018)

})
