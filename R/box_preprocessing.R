boxPreprocessingUI <- function(id){
  ns <- NS(id)
  box(
    title = "Prétraitement",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,
    p("box content ...")
  )
}

boxPreprocessingServer <- function(id){
  moduleServer(
    id,
    function(input, output, session){}
  )
}
