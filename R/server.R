#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
server <- function(input, output, session) {
  addResourcePath("www", system.file("www", package = "shinyPOC"))

  boxDataServer("box_data")
  boxPreprocessingServer("box_preprocessing")
  boxMapServer("box_map")
  boxMetricsServer("box_server")
}
