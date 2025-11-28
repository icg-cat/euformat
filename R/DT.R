#' Apply EU-style number formatting in DT tables
#'
#' This helper integrates European-style formatting with the DT package.
#' Use it after creating a `datatable()` object to format one or more columns
#' using comma decimal marks, dot thousand separators, and optional currency.
#'
#' @param DTproxy A DT table created by `DT::datatable()`.
#' @param columns Character or numeric column indices to format.
#' @param digits Number of decimal digits to display.
#' @param currency Logical; if `TRUE` append `" €"` to formatted output.
#'
#' @return A DT object with formatted columns.
#' @export
#' @examples
#' df <- cbind(
#' item  = c("A", "B", "C", "D"),
#' value = c(2, 10, 1000.5, 12.34),
#' cost  = (c(2, 10, 1000.5, 12.34) * 1.3)
#' )
#' DT::datatable(df) |>
#' dt_format_eu(
#'  columns = c("value", "cost"),
#'  digits = 2, currency = TRUE
#')
#'
dt_format_eu <- function(DTproxy, columns, digits = 2, currency = FALSE) {
  if (isTRUE(currency)) {
    DTproxy <- DT::formatCurrency(
      DTproxy,
      columns   = columns,
      currency  = " \\u20ac",      # suffix
      digits    = digits,
      interval  = 3,
      mark      = ".",       # thousand separator
      dec.mark  = ",",       # decimal mark
      before    = FALSE      # put " €" after the number
    )
  } else {
    DTproxy <- DT::formatRound(
      DTproxy,
      columns   = columns,
      digits    = digits,
      interval  = 3,
      mark      = ".",       # thousand separator
      dec.mark  = ","        # decimal mark
    )
  }

  DT::formatStyle(
    DTproxy,
    columns,
    `white-space` = "nowrap"
  )
}
