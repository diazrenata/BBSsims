# BBSsims


<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/gh/diazrenata/BBSsims/branch/main/graph/badge.svg)](https://codecov.io/gh/diazrenata/BBSsims?branch=main)

This is a research compendium containing the code, data, and results supporting the manuscript "Shifts in the indivdiual size distribution decouple the long-term dynamics of abundance, biomass, and energy use for North American Breeding Birds", currently in review.

## All use cases

This repository includes specialized R functions written for this analysis. They are structured as an R package. To use them:

1. Download this repository to your computer
2. Open BBSsims.Rproj in RStudio
3. In RStudio's "Build" pane, click Install
4. You may have to update or install package dependencies

Alternatively, you can open R and run:

```
remotes::install_github("diazrenata/BBSsims")
```

You will still have to install or update dependencies. 

## To re-render the mansucript and supplement

We have provided all materials necessary to re-render the figures and tables from the manuscript and supplements in `analysis/writing/submission1/source_documents`. To re-render these materials, open the .Rmd documents and re-run them.

If you would like to explore the final results more fully, we have provided the main results files as .RDS files in  `analysis/results/foo.RDS`. To load these, use:

```

readRDS(here::here("analysis", "results", "foo.RDS"))

```


If you prefer to re-run the full analytical pipeline, use the instructions following. 


## To re-run the analyses

Open `analysis/pipelines/pipeline.R`, select all, and run. If you run the script as written, it will take around 24 hours (using a single core of your computer). If you just want to run the analytical pipeline on a few routes to explore it, uncomment line 20:

```
#datasets <- datasets[1:5, ]
```

to run on just a few routes.

## To explore the final results


The analysis script will save everything to an .sqlite cache at `analysis/caches/all.sqlite`. You can load objects into R like this (this will load the major results files):

```
library(drake)

db <- DBI::dbConnect(RSQLite::SQLite(), here::here("analysis", "caches", "all.sqlite"))
cache <- storr::storr_dbi("datatable", "keystable", db)
cache$del(key = "lock", namespace = "session")

loadd(foo, cache = cache)

```

If you do not want to rerun the pipeline, you can load the copies we have provided using:

```

readRDS(here::here("analysis", "results", "foo.RDS"))

```


