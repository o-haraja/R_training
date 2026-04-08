#!/bin/bash
set -e

# Install R packages
R -e "install.packages(c('patchwork', 'janitor', 'here', 'quarto', 'languageserver'), repos='https://cloud.r-project.org')"

# Start RStudio Server
sudo rstudio-server start

echo "✅ R is ready! RStudio available on port 8787."
