boxMetricsUI <- function(id){
  ns <- NS(id)
  box(
    title = "Indicateurs",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,
    p("box content ...")
  )
}

boxMetricsServer <- function(id){
  moduleServer(
    id,
    function(input, output, session){}
  )
}
