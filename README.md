
\#code generated with README.Rmd

# assignmentB2CiaraRitchie

## Description

This package consists of a function (normalize_volumes.R) that can be
used to calculate normalized regional brain volumes relative to total
cerebral brain volume (TCV), organizing output by a specified grouping
variable, such as cohort or sex.

## Installation

You can install the development version of assignmentB2CiaraRitchie from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
devtools::install_github(
  "UBC-STAT545-F2026/assignmentB2CiaraRitchie",
  ref = "0.1.0"
)
```

## Demonstrated Usage

### Example

This is a basic example:

``` r
library(assignmentB2CiaraRitchie)

data <- data.frame(
  cohort = c("A", "A", "B", "B"),
  sex = c("F", "M", "F", "M"),
  thalamus_volume = c(14000, 15000, 13000, 15000),
  tcv = c(1500000, 1600000, 1200000, 1450000)
)

normalize_volumes(
  data = data,
  group = "cohort",
  x = "thalamus_volume",
  y = "tcv"
)
#> # A tibble: 4 × 5
#> # Groups:   cohort [2]
#>   cohort sex   thalamus_volume     tcv normalized_volume
#>   <chr>  <chr>           <dbl>   <dbl>             <dbl>
#> 1 A      F               14000 1500000             0.933
#> 2 A      M               15000 1600000             0.938
#> 3 B      F               13000 1200000             1.08 
#> 4 B      M               15000 1450000             1.03
```

This function adds a new column called ‘normalized_volume’ which
represents the regional brain volume (in this example thalamus volume)
as a percentage of TCV, grouping the output by cohort)
