boxMetricsUI <- function(id){
  ns <- NS(id)
  box(
    id = ns("box_id"), ## to manipulate box by shinyjs
    title = "Indicateurs d'exposition",
    width = NULL,
    collapsible = TRUE,
    collapsed = TRUE,
    status = "primary",
    solidHeader = TRUE,

    uiOutput(ns("esurf_title")),
    tableOutput(ns("esurf_table")),
    plotOutput(ns("esurf_plot"))
  )
}

boxMetricsServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){
      observe({
        output$esurf_title <- renderUI({
          if(isTruthy(data$esurf)){
            h5("Exposition à l'eau de surface")
          } else {
            p("Un calcul d'exposition à l'eau de surface est nécessaire pour visualiser cet indicateur.")
          }
        })

        output$esurf_table <- renderTable({
          req(data$esurf)
          esurf_table <- data.frame(
            "Total"=length(data$esurf),
            "Exposé"=sum(data$esurf),
            "Non exposé"=sum(!data$esurf))
          esurf_table
        })

        output$esurf_plot <- renderPlot({
          req(data$esurf)
          esurf_class <- rep("Non exposé", length(data$esurf))
          esurf_class[ data$esurf ] <- "Exposé"
          esurf_df <- data.frame(
            "Récurrence" = rep(1, length(data$esurf)),
            "Exposition"=esurf_class)

          ggplot2::ggplot(data=esurf_df, ggplot2::aes(y="Récurrence", fill=Exposition)) +
            ggplot2::geom_bar()
        })
      })
    }
  )
}
