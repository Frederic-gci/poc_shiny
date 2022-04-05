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
      dashboardHeader(title = "shiny pour oracle"),
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
        shinyjs::useShinyjs(),
        shinyjs::extendShinyjs(script = "/www/shinyjs.js", functions = c("collapse")),
        tabItems(
          tabItem(
            tabName = "analysis",
            fluidRow(
              column(
                width=6,
                boxDataUI('box_data'),
                boxPreprocessingUI("box_preprocessing")
              ),
              column(
                width=6,
                boxSummaryUI("box_summary")
              )
            ),
            fluidRow(
              column(
                width=12,
                boxMapUI("box_map")
              )
            ),
            fluidRow(
              column(
                width=6,
                boxMetricsUI("box_metrics")
              )
            )
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
