#' Turn European-style printing on or off
#'
#' These functions enable or disable EU-style formatting for objects of
#' class `eu_num`. When disabled, values print as raw numerics.
#'
#' This is useful for debugging, exporting raw numeric data, or temporarily
#' disabling formatting inside complex workflows.
#'
#' @return Invisibly returns `TRUE`.
#' @export
#' @examples
#' # Turn formating on
#' x <- eu_num(12345.67)
#' eu_format_on()
#' x
#' x*2
#' # Turn formating off
#' eu_format_off()
#' x
#' x*2
eu_format_on  <- function() {
  .euformat_state$enabled <- TRUE
  invisible(TRUE)
}

#' @rdname eu_format_on
#' @export
eu_format_off <- function() {
  .euformat_state$enabled <- FALSE
  invisible(TRUE)
}

#' @rdname eu_format_on
#' @export
eu_format_is_on <- function() {
  isTRUE(.euformat_state$enabled)
}
