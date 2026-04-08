FROM rocker/tidyverse:4.5.0

# Pre-install languageserver and other packages at image build time
RUN Rscript -e "install.packages(c('languageserver', 'patchwork', 'janitor', 'here', 'quarto'), repos='https://cloud.r-project.org')"
