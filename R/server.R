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
    "building_file" = NULL
  )

  boxDataServer("box_data", roots=roots, data=data)
  boxPreprocessingServer("box_preprocessing")
  boxMapServer("box_map")
  boxMetricsServer("box_metrics", data=data)
}
