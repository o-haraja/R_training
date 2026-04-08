# install_packages.R — runs at Docker BUILD time (as root)
# Packages land in /usr/local/lib/R/site-library (shared, world-readable)

message("=== Installing R packages ===")
options(
  repos    = c(CRAN = "https://cloud.r-project.org"),
  warn     = 1,
  Ncpus    = max(1L, parallel::detectCores() - 1L)
)

pkgs <- c(
  # ── Requested ──────────────────────────────────────────────────
  "tidyverse",    # meta-package: ggplot2, dplyr, tidyr, readr, purrr, etc.
  "dplyr",
  "fs",
  "knitr",
  "patchwork",

  # ── R Markdown / Quarto ─────────────────────────────────────────
  "rmarkdown",
  "quarto",
  "yaml",
  "jsonlite",
  "htmltools",
  "htmlwidgets",

  # ── Useful extras ───────────────────────────────────────────────
  "here",
  "glue",
  "lubridate",
  "readxl",
  "writexl",
  "janitor",
  "skimr",
  "gt",
  "scales",
  "ggthemes",
  "ragg",

  # ── VS Code integration (must be present at startup) ────────────
  "languageserver",   # powers autocompletion + diagnostics in the R extension
  "httpgd"            # renders plots in the VS Code Plots panel
)

missing_pkgs <- pkgs[!pkgs %in% rownames(installed.packages())]

if (length(missing_pkgs) == 0) {
  message("All packages already installed.")
} else {
  message("Installing ", length(missing_pkgs), " packages: ",
          paste(missing_pkgs, collapse = ", "))
  install.packages(missing_pkgs)
}

# Verify every package actually loads
message("\n=== Verifying installs ===")
failed <- character()
for (pkg in pkgs) {
  ok <- requireNamespace(pkg, quietly = TRUE)
  message(sprintf("  %-20s %s", pkg, if (ok) "OK" else "FAILED"))
  if (!ok) failed <- c(failed, pkg)
}

if (length(failed) > 0) {
  stop("The following packages failed to install: ", paste(failed, collapse = ", "))
}

message("\n=== All packages installed and verified ===")
message("R version: ", R.version.string)
