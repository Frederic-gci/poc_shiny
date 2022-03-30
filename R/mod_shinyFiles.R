#' A formatted directory input using shinyFiles
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#' @param label The button label.
#' @param title The browser window title.
#'
#' @import shiny
dirChooserUI <- function(id, label, title) {
  ns <- NS(id)
  div(class="input-group form-group",
    div(class="input-group-btn",  style="vertical-align:top;",
      shinyFiles::shinyDirButton(
        id=ns("directory"),
        label=label,
        title=title
      )
    ),
    tags$input(
      id=ns("dir_display"),
      type="text", readonly="readonly",
      placeholder="Aucun répertoire sélectionné",
      class="form-control"
    )
  )
}

#' A formatted directory input using shinyFiles
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#' @param roots 	A named vector of absolute filepaths or a function returning a named vector of absolute filepaths (the latter is useful if the volumes should adapt to changes in the filesystem).
#' @param allowDirCreate Logical that indicates if creating new directories by the user is allowed.
#'
#' @import shiny
dirChooserServer <- function(id, roots, allowDirCreate=TRUE) {
  moduleServer(
    id,
    function(input, output, session) {
      shinyFiles::shinyDirChoose(input, "directory",
        roots = roots, session = session,
        restrictions = system.file(package = "base"),
        allowDirCreate = allowDirCreate
      )
      observe({
        updateTextInput(
          session=session,
          inputId="dir_display",
          value=shinyFiles::parseDirPath(roots, input$directory)
        )
      })
      return(reactive(input$directory))
    }
  )
}

#' A formatted file input using shinyFiles
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#' @param label The button label.
#' @param title The browser window title.
#' @param multiple A logical indicating whether or not it should be possible to select multiple files
#' @param filetypes A character vector of file extensions (without dot in front i.e. 'txt' not '.txt') to include in the output. Use the empty string to include files with no extension. If not set all file types will be included
#' @param pattern A regular expression used to select files to show. See base::grepl() for additional discussion on how to construct a regular expression (e.g., "log.*\\.txt")
#'
#' @import shiny
fileChooserUI <- function(id, label, title, multiple=TRUE, filetypes=NULL, pattern=NULL){
  ns <- NS(id)
  div(class="input-group form-group",
    div(class="input-group-btn",  style="vertical-align:top;",
      shinyFiles::shinyFilesButton(
        id=ns("file"),
        label=label,
        title=title,
        multiple=multiple,
        filetypes=filetypes,
        pattern=pattern
      )
    ),
    tags$input(
      id=ns("file_display"),
      type="text", readonly="readonly",
      placeholder="Aucun fichier sélectionné",
      class="form-control"
    )
  )
}

#' A formatted file input using shinyFiles
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#' @param roots 	A named vector of absolute filepaths or a function returning a named vector of absolute filepaths (the latter is useful if the volumes should adapt to changes in the filesystem).
#'
#' @import shiny
fileChooserServer <- function(id, roots){
  moduleServer(
    id,
    function(input, output, session){
      shinyFiles::shinyFileChoose(input, "file",
        roots = roots, session = session,
        restrictions = system.file(package = "base")
      )
      observe({
        file_df <- shinyFiles::parseFilePaths(roots, input$file)
        file <- paste0(file_df$datapath, file_df$name)
        updateTextInput(
          session=session,
          inputId="file_display",
          value=file
        )
      })
      return(reactive(input$file))
    }
  )
}

#' A formatted directory input with the UI rendered from the server function to enable resetting.
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#'
#' @import shiny
dirChooserWithResetUI <- function(id) {
  ns <- NS(id)
  uiOutput(outputId=ns('input_div'))
}

#' A formatted directory input with the UI rendered from the server to enable resetting.
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#' #' @param roots 	A named vector of absolute filepaths or a function returning a named vector of absolute filepaths (the latter is useful if the volumes should adapt to changes in the filesystem).
#' @param label The button label.
#' @param title The browser window title.
#' @param reset A reactive value to trigger the re-rendering of the UI.
#'
#' @import shiny
dirChooserWithResetServer <- function(id, roots, label, title, reset) {
  moduleServer(
    id,
    function(input, output, session) {
      shinyFiles::shinyDirChoose(input, "directory",
        roots = roots, session = session,
        restrictions = system.file(package = "base"),
        allowDirCreate = TRUE
      )
      observe({
        updateTextInput(
          session=session,
          inputId="dir_display",
          value=shinyFiles::parseDirPath(roots, input$directory)
        )
      })
      output$input_div <- renderUI({
        ns <- session$ns
        reset()
        div(class="input-group form-group",
          div(class="input-group-btn",  style="vertical-align:top;",
            shinyFiles::shinyDirButton(
              id=ns("directory"),
              label=label,
              title=title
            )
          ),
          tags$input(
            id=ns("dir_display"),
            type="text", readonly="readonly",
            placeholder="Aucun répertoire sélectionné",
            class="form-control"
          )
        )
      })
      return(reactive(input$directory))
    }
  )
}

#' A formatted directory input using shinyFils with the UI rendered from the server to enable resetting.
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#'
#' @import shiny
fileChooserWithResetUI <- function(id){
  ns <- NS(id)
  uiOutput(outputId=ns('input_div'))
}

#' A formatted directory input using shinyFils with the UI rendered from the server to enable resetting.
#' The format is based on AdminLTE v2 (shinydashboard)
#'
#' @param id Module id.
#' @param roots 	A named vector of absolute filepaths or a function returning a named vector of absolute filepaths (the latter is useful if the volumes should adapt to changes in the filesystem).
#' @param reset A reactive value to trigger the re-rendering of the UI.
#' @param label The button label.
#' @param title The browser window title.
#' @param multiple A logical indicating whether or not it should be possible to select multiple files
#' @param filetypes A character vector of file extensions (without dot in front i.e. 'txt' not '.txt') to include in the output. Use the empty string to include files with no extension. If not set all file types will be included
#' @param pattern A regular expression used to select files to show. See base::grepl() for additional discussion on how to construct a regular expression (e.g., "log.*\\.txt")
#'
#' @import shiny
fileChooserWithResetServer <- function(id, roots, reset, label, title, multiple=TRUE, filetypes=NULL, pattern=NULL){
  moduleServer(
    id,
    function(input, output, session){
      reset
      shinyFiles::shinyFileChoose(input, "file",
        roots = roots, session = session,
        restrictions = system.file(package = "base")
      )
      observe({
        file_df <- shinyFiles::parseFilePaths(roots, input$file)
        file <- paste0(file_df$datapath, file_df$name)
        updateTextInput(
          session=session,
          inputId="file_display",
          value=paste0(file_df$datapath,collapse=";")
        )
      })
      output$input_div <- renderUI({
        ns <- session$ns
        reset()
        div(class="input-group form-group",
          div(class="input-group-btn",  style="vertical-align:top;",
            shinyFiles::shinyFilesButton(
              id=ns("file"),
              label=label,
              title=title,
              multiple=multiple,
              filetypes=filetypes,
              pattern=pattern
            )
          ),
          tags$input(
            id=ns("file_display"),
            type="text", readonly="readonly",
            placeholder="Aucun fichier sélectionné",
            class="form-control"
          )
        )
      })

      return(reactive(input$file))
    }
  )
}
