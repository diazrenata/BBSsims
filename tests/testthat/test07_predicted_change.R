dat <- hartland

svs <- get_annual_state_variables(dat)

mods <-  fit_trend_models_biomass(svs)

test_that("getting predicted change works", {

  expect_silent(model_predicted_change(mods[[1]]))
  expect_warning(model_predicted_change(mods[[4]]), "the standard deviation is zero")


  expect_silent(model_predicted_change(mods[[5]]))
  expect_warning(model_predicted_change(mods[[8]]), "the standard deviation is zero")

  changes <- all_models_predicted_change(mods)

  expect_true(changes$ratio_real[8] == 1)
  expect_true(changes$ratio_sim[8] == 1)

  expect_true(changes$ratio_real[5] > 1)
  expect_true(changes$ratio_sim[5] < 1)


})
