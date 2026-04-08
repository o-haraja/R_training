# install_packages.R
# Installs all required R packages for this Codespace environment
# Run automatically via postCreateCommand in devcontainer.json

message("=== Installing R packages ===")

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Helper: install only if not already installed
install_if_missing <- function(pkgs) {
  missing <- pkgs[!pkgs %in% rownames(installed.packages())]
  if (length(missing) > 0) {
    message("Installing: ", paste(missing, collapse = ", "))
    install.packages(missing)
  } else {
    message("Already installed: ", paste(pkgs, collapse = ", "))
  }
}

# ── Core / Requested packages ──────────────────────────────────────────────────
core_packages <- c(
  "tidyverse",   # ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, forcats
  "dplyr",       # explicit in case tidyverse install is partial
  "fs",          # file system operations
  "knitr",       # R Markdown engine
  "patchwork"    # combine ggplot2 plots
)

install_if_missing(core_packages)

# ── R Markdown & Quarto support ────────────────────────────────────────────────
rmd_packages <- c(
  "rmarkdown",   # R Markdown rendering
  "quarto",      # Quarto R package
  "yaml",        # YAML front-matter parsing
  "jsonlite",    # JSON support (used by many packages)
  "htmltools",   # HTML generation helpers
  "htmlwidgets"  # interactive widgets in Rmd/Quarto
)

install_if_missing(rmd_packages)

# ── Useful extras ──────────────────────────────────────────────────────────────
extra_packages <- c(
  "here",        # project-relative paths
  "glue",        # string interpolation
  "lubridate",   # date/time handling
  "readxl",      # read Excel files
  "writexl",     # write Excel files
  "janitor",     # data cleaning helpers
  "skimr",       # quick data summaries
  "gt",          # publication-quality tables
  "scales",      # scale helpers for ggplot2
  "ggthemes",    # extra ggplot2 themes
  "ragg"         # fast PNG/TIFF graphics device
)

install_if_missing(extra_packages)

# ── VS Code integration ────────────────────────────────────────────────────────
vscode_packages <- c(
  "languageserver",  # R Language Server (autocompletion, diagnostics)
  "httpgd"           # graphics device for VS Code R plots panel
)

install_if_missing(vscode_packages)

message("=== All packages installed successfully ===")
message("R version: ", R.version.string)
message("Installed packages count: ", nrow(installed.packages()))
