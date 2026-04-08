# Use Rocker's tidyverse image as base (includes R, RStudio-ready libs, pandoc, LaTeX basics)
FROM rocker/tidyverse:latest

# Install system dependencies for common R packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    # For curl / httr / rvest
    libcurl4-openssl-dev \
    libssl-dev \
    # For xml2 / rvest
    libxml2-dev \
    # For sf / spatial packages
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    # For ragg / textshaping (ggplot2 rendering)
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    # For database connectivity
    libsqlite3-dev \
    # Quarto dependencies
    wget \
    curl \
    gdebi-core \
    # Pandoc (usually included but ensuring)
    pandoc \
    # Git (for renv and version control)
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto CLI
RUN QUARTO_VERSION=$(curl -sL https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest \
      | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/') \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && gdebi --non-interactive "quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-amd64.deb"

# Create directory for setup scripts
RUN mkdir -p /usr/local/lib/R/setup

# Copy the package installation script
COPY install_packages.R /usr/local/lib/R/setup/install_packages.R

# Install httpgd for VS Code R plots
RUN Rscript -e "install.packages('httpgd', repos = 'https://cloud.r-project.org')"

# Install languageserver for VS Code R extension
RUN Rscript -e "install.packages('languageserver', repos = 'https://cloud.r-project.org')"
