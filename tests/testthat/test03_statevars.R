dat <- granby

dat$covariates$year <- dat$covariates$year - 5

svs <- get_annual_state_variables(dat)

test_that("pull focal years gives expected", {

  focal_years <- pull_focal_years(dat)

  expect_false(all(dat$covariates$year %in% 1988:2018))
  expect_true(all(focal_years$covariates$year %in% 1988:2018))

})



test_that("relative abundance null model gives expected", {

  ra_nm <- relabund_null_model(dat)
  ra_nm2 <-  relabund_null_model(dat)
  ra_nm3 <-  relabund_null_model(dat, resp_seed = 2000)

  expect_true(all(ra_nm$abundance == ra_nm2$abundance))
  expect_false(all(ra_nm$abundance == ra_nm3$abundance))

  manual_relabunds <- dat$abundance / rowSums(dat$abundance)

  manual_avg_relabunds <- apply(manual_relabunds, MARGIN = 2, FUN = mean)
  set.seed(1989)
  manual_relabunds_draw <- t(rmultinom(1, size = rowSums(dat$abundance[1,]), prob = manual_avg_relabunds))

  expect_true(all(manual_relabunds_draw == ra_nm$abundance[1,]))

})


test_that("ISD sim gives expected", {

  real_isd <- simulate_isd_ts(dat, isd_seed = 1989)

  expect_true(round(real_isd$isd$mass[1]) == 320)


})


test_that("svs on ISD gives expected", {

  real_isd <- BBSsims::simulate_isd_ts(dat, isd_seed = 1989)

  real_sv <- calc_sv(real_isd)

  biomass_sv <- real_isd$isd %>%
    dplyr::group_by(year) %>%
    dplyr::summarize(total_mass = sum(mass),
                     total_energy = sum(BBSsims::estimate_b(mass))) %>%
    ungroup()

  expect_true(all(biomass_sv$total_mass == real_sv$total_biomass))
  expect_true(all(biomass_sv$total_energy == real_sv$total_energy))

  expect_true(all(unique(svs$source) == c("real", "sim")))

})
