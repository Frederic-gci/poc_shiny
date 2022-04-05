#' Launch the application
#'
#'@export
oracle <- function(){
  shiny::shinyApp(ui, server)
}
