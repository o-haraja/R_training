# R Codespace

A GitHub Codespace pre-configured for R development with R Markdown and Quarto support.

## What's included

### Tools
| Tool | Details |
|---|---|
| **R** | Latest release via `rig` |
| **R Markdown** | Via `rmarkdown` + `knitr` |
| **Quarto** | Latest Quarto CLI |
| **pandoc** | Bundled with Quarto |

### VS Code Extensions
- **R** — syntax highlighting, code lens, integrated terminal
- **R Debugger** — breakpoints and debugging
- **Quarto** — `.qmd` preview and rendering
- **Markdown All in One** — `.Rmd` editing helpers

### R Packages

| Package | Purpose |
|---|---|
| `tidyverse` | Core data science toolkit |
| `dplyr` | Data manipulation |
| `fs` | File system operations |
| `knitr` | R Markdown engine |
| `patchwork` | Combine ggplot2 plots |
| `rmarkdown` | R Markdown rendering |
| `quarto` | Quarto R integration |
| `here` | Project-relative paths |
| `glue` | String interpolation |
| `lubridate` | Date/time handling |
| `readxl` / `writexl` | Excel I/O |
| `janitor` | Data cleaning |
| `skimr` | Quick data summaries |
| `gt` | Publication tables |
| `ggthemes` | Extra ggplot2 themes |
| `ragg` | Fast graphics device |
| `languageserver` | VS Code R autocompletion |
| `httpgd` | VS Code R plots panel |

## Getting started

### Open an R terminal
1. Press `` Ctrl+` `` to open the integrated terminal
2. Type `R` and press Enter

### Render R Markdown
```bash
Rscript -e "rmarkdown::render('starter.Rmd')"
```

### Render Quarto
```bash
quarto render starter.qmd
# or for live preview:
quarto preview starter.qmd
```

### Forwarded ports
| Port | Purpose |
|---|---|
| `3838` | Shiny apps |
| `4321` | Quarto preview |

## File structure
```
.
├── .devcontainer/
│   ├── devcontainer.json   # Codespace configuration
│   ├── Dockerfile          # Container image definition
│   └── install_packages.R  # R package installer
├── starter.Rmd             # Sample R Markdown document
├── starter.qmd             # Sample Quarto document
├── .gitignore
└── README.md
```
