boxMetricsUI <- function(id){
  ns <- NS(id)
  box(
    title = "Sommaire et indicateurs",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,

    h4("Fichiers des données entrantes"),
    verbatimTextOutput(outputId = ns("files")),

    h4("Systèmes de projection des données entrantes"),
    verbatimTextOutput(outputId = ns("projections")),

    h4("Temporaire - exploration de l'objet 'data'"),
    verbatimTextOutput(outputId = ns("data")),
  )
}

boxMetricsServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){
      output$data = renderPrint(data)

      output$files = renderText(paste(
        "mnt_file = ", data$mnt_file,
        "\nhazard_file = ", data$hazard_file,
        "\nbuilding_file = ", data$building_file))

      output$projections = renderPrint("TO DO")

    }
  )
}
