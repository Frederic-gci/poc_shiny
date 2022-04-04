boxMetricsUI <- function(id){
  ns <- NS(id)
  box(
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
