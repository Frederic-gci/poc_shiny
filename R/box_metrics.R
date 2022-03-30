boxMetricsUI <- function(id){
  ns <- NS(id)
  box(
    title = "Sommaire et indicateurs",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,

    h4("Données entrantes"),
    verbatimTextOutput(outputId = ns("data_content")),

    h4("Temporaire - exploration de l'objet 'data'"),
    verbatimTextOutput(outputId = ns("data_elements")),
  )
}

boxMetricsServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){
      output$data_elements = renderPrint(data)

      output$data_content = renderText(paste(
        "mnt_file = ", data$mnt_file,
        "\nhazard_file = ", data$hazard_file,
        "\nbuilding_file = ", data$building_file))
    }
  )
}
