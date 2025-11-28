#' Create an EU-formatted numeric vector
#' This constructor wraps a numeric vector with the `eu_num` S3 class, allowing it to print using European number formatting (comma as decimal mark, dot as thousands separator).
#' @param x A numeric vector.
#' @param digits Integer vector specifying decimal digits.
#'   Can be of length 1 or the same length as `x`.
#' @param currency Logical; if `TRUE` append `" €"` to formatted output.
#' @return An object of class `eu_num` (and `"numeric"` underneath).
#' @export
#' @rdname eu_num
#' @examples
#' eu_num(pi)
eu_num <- function(x, digits = 2, currency = FALSE) {
  stopifnot(is.numeric(x))
  structure(
    x,
    digits = rep(digits, length(x)),
    currency = currency,
    class = c("eu_num", class(x))
  )
}


#' @export
#' @inheritParams eu_num
#' @rdname euformat
#' @examples
#' eu_currency(pi)
eu_currency <- function(x, digits = 2) {
  eu_num(x, digits = digits, currency = TRUE)
}
