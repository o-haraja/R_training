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

# ── Install R from CRAN apt repo → lands at /usr/bin/R ────────────────────────
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
      | gpg --dearmor -o /usr/share/keyrings/r-project.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/r-project.gpg] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" \
      > /etc/apt/sources.list.d/r-project.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends r-base r-base-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ── Install Quarto CLI ─────────────────────────────────────────────────────────
RUN QUARTO_VERSION=$(curl -sL https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest \
      | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/') \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && gdebi --non-interactive "quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-amd64.deb"

# ── Create a world-writable R library so the vscode user can install packages ──
# /usr/local/lib/R/site-library is on R's default .libPaths(), so packages
# installed here are visible to every user without any extra configuration.
RUN chmod -R 777 /usr/local/lib/R/site-library

# ── Install ALL R packages now, as root, into the shared system library ────────
# This is the key fix: packages go into the container image itself, so they are
# available immediately when the Codespace starts — no waiting for postCreate.
COPY install_packages.R /tmp/install_packages.R
RUN Rscript /tmp/install_packages.R

