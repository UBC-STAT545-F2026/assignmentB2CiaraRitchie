### Test 1: Does the function correctly calculate normalized brain volumes?

test_that("Function correctly calculates normalized brain volume", {

  data1 <- data.frame(
    cohort = c("A", "A", "B", "B"),
    sex = c("F", "M", "F", "M"),
    thalamus_volume = c(14000, 15000, 13000, 15000),
    tcv = c(1500000, 1600000, 1200000, 1450000)
  )

  result <- normalize_volumes(
    data = data1,
    group = "cohort",
    x = "thalamus_volume",
    y = "tcv"
  )

  # Check that normalized volumes match the manually calculated values
  expect_equal(
    result$normalized_volume,
    c(0.9333333333, 0.9375, 1.0833333333, 1.0344827586)
  )

})

### Test 2: Does it correctly group by cohort

test_that("Function correctly groups observations by cohort", {

  data1 <- data.frame(
    cohort = c("A", "A", "B", "B"),
    sex = c("F", "M", "F", "M"),
    thalamus_volume = c(14000, 15000, 13000, 15000),
    tcv = c(1500000, 1600000, 1200000, 1450000)
  )

  result <- normalize_volumes(
    data = data1,
    group = "cohort",
    x = "thalamus_volume",
    y = "tcv"
  )

  # Check that the output is grouped by cohort
  expect_equal(dplyr::group_vars(result), "cohort")

})


### Test 3: Test that this function keeps NA variables in the dataframe (not all of my participants have every field, so want to keep them in the dataframe regardless of if they don't have specific volumes)

test_that("Function correctly preserves missing values", {

  # Create a dataset containing a missing regional volume
  data_na <- data.frame(
    cohort = c("A", "A", "B", "B"),
    sex = c("F", "M", "F", "M"),
    thalamus_volume = c(NA, 15000, 13000, 15000), #making first value NA
    hippocampus_volume = c(4000, 4500, 3900, 4200),
    tcv = c(1500000, 1600000, 1200000, 1450000)
  )


  result <- normalize_volumes(
    data = data_na,
    group = "cohort",
    x = "thalamus_volume",
    y = "tcv"
  )

  # Check that the missing value is preserved in the output, specifing the first value!
  expect_true(is.na(result$normalized_volume[1]))

})

### Test 4: Does the cuntion produce an error for non-numeric volumes (new addition test)

test_that("Function produces an error for non-numeric volumes", {

  data_invalid <- data.frame(
    cohort = c("A", "B"),
    thalamus_volume = c("large", "small"),
    tcv = c(1500000, 1600000)
  )

  expect_error(
    normalize_volumes(data_invalid, "cohort",
                      "thalamus_volume", "tcv"),
    "Input must be numeric!"
  )

})

