# This script loads the major results objects from the cache and saves them as .RDS files in `analysis/results`.

library(dplyr)
library(drake)

## Set up the cache and config
db <- DBI::dbConnect(RSQLite::SQLite(), here::here("analysis", "caches", "all.sqlite"))
cache <- storr::storr_dbi("datatable", "keystable", db)
cache$del(key = "lock", namespace = "session")


loadd(all_sims, cache=cache)

loadd(all_preds_b, cache=cache)

loadd(all_aics_b, cache=cache)

loadd(all_preds_e, cache=cache)

loadd(all_aics_e, cache=cache)

loadd(all_cs_compares, cache =cache)

saveRDS(all_sims, here::here("analysis", "results", "all_sims.RDS"))
saveRDS(all_preds_b, here::here("analysis", "results", "all_preds_b.RDS"))
saveRDS(all_aics_b, here::here("analysis", "results", "all_aics_b.RDS"))
saveRDS(all_preds_e, here::here("analysis", "results", "all_preds_e.RDS"))
saveRDS(all_aics_e, here::here("analysis", "results", "all_aics_e.RDS"))
saveRDS(all_cs_compares, here::here("analysis", "results", "all_cs_compares.RDS"))
