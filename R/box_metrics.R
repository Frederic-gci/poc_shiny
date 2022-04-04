boxMetricsUI <- function(id){
  ns <- NS(id)
  box(
    id = ns("box_id"), ## to manipulate box by shinyjs
    title = "Indicateurs",
    width = NULL,
    collapsible = TRUE,
    status = "primary",
    solidHeader = TRUE,
  )
}

boxMetricsServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){}
  )
}
