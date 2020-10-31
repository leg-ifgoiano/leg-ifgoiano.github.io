before_install:
  - Rscript -e 'install.packages(c("rmarkdown", "devtools", "leaflet", "shiny"))'
  - Rscript -e "rmarkdown::render_site()"
