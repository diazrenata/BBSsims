dat <- hartland

svs <- get_annual_state_variables(dat)


test_that("fitting trend models works", {

  biomass_trend_models <- fit_trend_models_biomass(svs)
  model_eval <- eval_trend_models(biomass_trend_models)



})
