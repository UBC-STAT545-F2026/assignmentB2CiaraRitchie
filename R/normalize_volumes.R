
#' @title Outputing Normalized Brain Volumes
#'
#' @importFrom magrittr %>%
#'
#' @description Takes a regional brain volume, divides by total cerebral    brain volume, and multiplies by 100, organizing output by group
#'
#' @param data Contains the variables you are working with, hence named data
#' @param group How data is grouped (eg. cohort, sex) could be numeric, character, or factor, hence named group
#' @param x Represents regional brain volume (numeric), named x for flexibility
#' @param y Represents total cerebral volume (numeric), named y for flexibility
#'
#' @return Generates a tibble with all original variables and an additional column "normalized_volumes" representing regional brain volume as a percent of total cerebral volume. Each row represents one observation, which are grouped by specified grouping variable.
#'
#' @examples
#'
#' # Example 1
#' data1 <- data.frame(
#'   cohort = c("A", "A", "B", "B"),
#'   sex = c("F", "M", "F", "M"),
#'   thalamus_volume = c(14000, 15000, 13000, 15000),
#'   tcv = c(1500000, 1600000, 1200000, 1450000)
#' )
#'
#'
#' normalize_volumes(
#'   data = data1,
#'   group = "cohort",
#'   x = "thalamus_volume",
#'   y = "tcv"
#' )
#'
#' # Example 2
#'
#'data2 <- data.frame(
#'cohort = c("A", "A", "B", "B"),
#'sex = c("F", "M", "F", "M"),
#'thalamus_volume = c(14000, 15000, 13000, 15000),
#'hippocampus_volume = c("large", "small", "medium", "small"),
#'tcv = c(1500000, 1600000, 1200000, 1450000))
#'
#'try(
#'normalize_volumes(
#'data = data2,
#'group = "sex",
#'x = "hippocampus_volume",
#'y = "tcv"))
#'
#' @export

normalize_volumes <- function(data, group, x, y){ #base function #x would be regional volume and y would be TCV

  if (!is.numeric(data[[x]]) || !is.numeric(data[[y]])) {
    stop("Input must be numeric!") #using a wrapper function
  }

  data %>%
    dplyr::mutate(normalized_volume=(.data[[x]]/.data[[y]])* 100) %>% #new column for output
    dplyr::group_by(.data[[group]]) #group by different cohorts for easy referencing
}

