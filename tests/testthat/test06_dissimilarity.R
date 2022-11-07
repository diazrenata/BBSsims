dat = hartland

test_that("comparing structure works", {
  str_comp <- compare_community_structure(dat)

  expect_true(signif(str_comp$real_overlap, 3) == .873)
  expect_true(signif(str_comp$sp_turnover_bcd, 3) == .247)

  expect_true(str_comp$begin_years == c("1994, 1995, 1996, 1997, 1998"))
  expect_true(str_comp$end_years == c("2014, 2015, 2016, 2017, 2018"))


})
