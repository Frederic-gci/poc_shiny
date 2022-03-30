boxMapUI <- function(id){
  ns <- NS(id)
  box(
    title = "Carte interactive",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,
    p("box content ...")
  )
}

boxMapServer <- function(id){
  moduleServer(
    id,
    function(input, output, session){}
  )
}
