# Global toggle
# Default: formatting enabled
.euformat_state <- new.env(parent = emptyenv())
.euformat_state$enabled <- TRUE



#' Format values using European number conventions
#'
#' This is a utility that applies EU-style formatting to numeric values:
#' comma decimal separator, dot thousands separator, and optional currency symbol.
#' It is the workhorse behind printing for the `eu_num` class.
#'
#' @inheritParams eu_num
#' @rdname euformat
#' @return A character vector.
#' @export
format_eu <- function(x, digits = 2, currency) {
  digits <- if (!missing(digits)) digits else attr(x, "digits")
  currency <- if (!missing(currency)) currency else attr(x, "currency")

  base <- mapply(
    function(val, dig) {
      formatC(
        val,
        format = "f",
        digits = dig,
        decimal.mark = ",",
        big.mark = "."
      )
    },
    val = unclass(x),
    dig = digits,
    USE.NAMES = FALSE
  )

  if (isTRUE(currency)) {
    base <- paste0(base, " \u20ac")
  }

  base
}


#' Format currency directly
#'
#' A convenience wrapper that formats numbers with European conventions and appends `" €"` automatically.
#'
#' @param x A numeric vector.
#' @param digits Number of decimal digits (scalar).
#'
#' @return A character vector.
#' @export
#' @rdname euformat
#'
format_currency <- function(x, digits = 2) {
  format_eu(eu_currency(x, digits = digits))
}


#' @method print eu_num
#' @exportS3Method
#'
print.eu_num <- function(x, ...) {
  if (.euformat_state$enabled) {
    out <- format_eu(x)
    print(out)
    return(invisible(x))
  }
  NextMethod()
}


#' @method format eu_num
#' @exportS3Method
#'
format.eu_num <- function(x, ...) {
  # Used when formatting inside data.frames
  if (.euformat_state$enabled) {
    format_eu(x)
  } else {
    NextMethod()
  }
}


#' @importFrom pillar pillar_shaft
#' @method pillar_shaft eu_num
#' @exportS3Method
#'
pillar_shaft.eu_num <- function(x, ...) {
  formatted <- if (.euformat_state$enabled) format_eu(x) else as.character(unclass(x))
  pillar::new_pillar_shaft_simple(formatted, align = "right")
}
