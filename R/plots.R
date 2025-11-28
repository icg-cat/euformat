#' Axis labelling helpers for ggplot2 using EU-style formatting
#'
#' These functions provide convenient ggplot2 scales that format axis
#' labels using European number conventions (comma decimals, dot thousands),
#' and optional currency symbols. Formatting respects the global toggle
#' (`eu_format_on()` / `eu_format_off()`).
#'
#' @param digits Number of decimal digits to show.
#' @param currency Logical; if TRUE, append `" €"` after formatting.
#'
#' @return A ggplot2 scale object.
#' @export
#' @examples
#' library(ggplot2)
#'
#' # Turn on EU-style formatting
#' eu_format_on()
#'
#' ggplot(mtcars, aes(x = hp, y = mpg)) +
#'   geom_point() +
#'   eu_scale_y() +
#'   eu_scale_x()
#'
#' # Turn formatting off again (optional cleanup for session)
#' eu_format_off()

eu_gg_labels <- function(digits = 2, currency = FALSE) {
  function(x) {
    if (.euformat_state$enabled) {
      format_eu(eu_num(x, digits = digits, currency = currency))
    } else {
      x
    }
  }
}

#' @rdname eu_gg_labels
#' @export
eu_scale_y <- function(digits = 2, currency = FALSE) {
  ggplot2::scale_y_continuous(labels = eu_gg_labels(digits, currency))
}

#' @rdname eu_gg_labels
#' @export
eu_scale_x <- function(digits = 2, currency = FALSE) {
  ggplot2::scale_x_continuous(labels = eu_gg_labels(digits, currency))
}
