#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
server <- function(input, output, session) {
  addResourcePath("www", system.file("www", package = "shinyPOC"))
  roots <- c(Home = fs::path_home(), shinyFiles::getVolumes()())

  # Reactive values:
  data <- reactiveValues(
    "mnt_file" = NULL,
    "hazard_file" = NULL,
    "building_file" = NULL,
    "cov_msg"="Aucun fichier de couverture généré",
    "cov" = NULL,
    "esurf_msg"="Aucun calcul esurf",
    "esurf" = NULL
  )

  boxDataServer("box_data", roots=roots, data=data)
  boxPreprocessingServer("box_preprocessing", data=data)
  boxMapServer("box_map")
  boxMetricsServer("box_metrics", data=data)
}
