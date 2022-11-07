dat <- hartland

svs <- get_annual_state_variables(dat)


test_that("fitting trend models works", {

  biomass_trend_models <- fit_trend_models_biomass(svs)
  energy_trend_models <- fit_trend_models_energy(svs)
  model_eval_b <- eval_trend_models(biomass_trend_models)
  model_eval_e <- eval_trend_models(energy_trend_models)

  expect_true(length(biomass_trend_models) == 8)
  expect_true(length(energy_trend_models) == 8)
  expect_true(all(class(biomass_trend_models[[1]]) == c("glm", "lm")))
  expect_true(all(class(biomass_trend_models[[8]]) == c("glm", "lm")))
  expect_true(all(class(energy_trend_models[[1]]) == c("glm", "lm")))
  expect_true(all(class(energy_trend_models[[8]]) == c("glm", "lm")))

  expect_false(anyNA(model_eval_b$model_AIC))
  expect_false(anyNA(model_eval_e$model_AIC))

  expect_true(is.na(model_eval_b$model_p[4]))
  expect_true(is.na(model_eval_e$model_p[4]))


})
