boxDataUI <- function(id){
  ns <- NS(id)
  box(
    title = "Données",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,
    p("box content ...")
  )
}

boxDataServer <- function(id){
  moduleServer(
    id,
    function(input, output, session){}
  )
}
