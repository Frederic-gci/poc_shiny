#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
#'
ui <- function(request) {
  tagList(
    tags$head(
      tags$link(rel = "icon", href = "/www/favicons/favicon.ico"),
      tags$link(rel = "stylesheet", type = "text/css", href = "/www/style.css")
    ),
    shinydashboard::dashboardPage(
      title = "shinyPOC",
      dashboardHeader(title = "POC Shiny"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Analyse",
            tabName = "analysis",
            icon = icon("chart-bar")
          ),
          menuItem("Utilitaires",
            tabName = "utils",
            icon = icon("toolbox")
          ),
          menuItem("Information",
            tabName = "info",
            icon = icon("info")
          )
        )
      ),
      dashboardBody(
        tabItems(
          tabItem(
            tabName = "analysis",
            h2("Analyse")
          ),
          tabItem(
            tabName="utils",
            box(
              title = "Page des utilitaires",
              status = "primary",
              solidHeader = FALSE,
              p("Cette page pourrait contenir des fonctions utilitaires permettant de construire adéquatement les données primaires."),
            )
          ),
          tabItem(
            tabName="info",
            box(
              title = "Page d'information",
              status = "primary",
              solidHeader = FALSE,
              p("Cette page pourrait contenir l'information sur le projet."),
            )

          )
        )
      )
    )
  )
}
