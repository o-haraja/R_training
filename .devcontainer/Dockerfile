# Base: Ubuntu 22.04 (same as GitHub Codespaces default — reliable user/path setup)
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# ── System dependencies ────────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    wget \
    curl \
    gdebi-core \
    pandoc \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libsqlite3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ── Install R from CRAN official apt repo ─────────────────────────────────────
# Installs R to /usr/bin/R — standard PATH, visible to all users including vscode
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
      | gpg --dearmor -o /usr/share/keyrings/r-project.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/r-project.gpg] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" \
      > /etc/apt/sources.list.d/r-project.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Confirm R is on PATH for all users
RUN which R && R --version | head -1

# ── Install Quarto CLI ─────────────────────────────────────────────────────────
RUN QUARTO_VERSION=$(curl -sL https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest \
      | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/') \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && gdebi --non-interactive "quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-amd64.deb"

# ── Install VS Code R integration packages at build time ──────────────────────
# languageserver → autocompletion, go-to-def, diagnostics
# httpgd         → renders plots in the VS Code Plots panel
RUN Rscript -e "\
    options(repos = c(CRAN = 'https://cloud.r-project.org')); \
    install.packages(c('languageserver', 'httpgd'), Ncpus = 2)"

# ── Copy package installer for postCreateCommand ──────────────────────────────
RUN mkdir -p /usr/local/lib/R/setup
COPY install_packages.R /usr/local/lib/R/setup/install_packages.R
