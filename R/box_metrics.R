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

    h4("Données entrantes chargées"),
    verbatimTextOutput(outputId = ns("data_objects")),

    h4("Données intermédiaires"),
    verbatimTextOutput(outputId = ns("intermediary"))
  )
}

boxMetricsServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){

      output$files = renderText({
        msg <- "Aucun fichier"
        paste0(
          "Fichier MNT = ", if(length(data$mnt_file)<1) msg else data$mnt_file,
          "\nFichier d'aléa = ",
          if(length(data$hazard_file)<1) msg else data$hazard_file,
          "\nFichier de bâtiments = ",
          if(length(data$building_file)<1) msg else data$building_file
        )
      })

      output$data_objects = renderText(
        paste0(
          "MNT = ", data$mnt_msg,
          "\nAléa = ", data$hazard_msg,
          "\nBâtiment = ", data$building_msg
        )
      )

      output$intermediary = renderText("To Do")
    }
  )
}
