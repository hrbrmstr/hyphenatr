context("Hyphenation works")
test_that("Basic ops and dictionary switching works", {

  expect_that(hyphenate("testing"), equals("test=ing"))

  switch_dict("hu_HU")

  expect_that(curr_dict(), equals("hu_HU"))

  expect_that(length(list_dicts()), equals(40))

  expect_that(hyphendict_is_loaded(), equals(TRUE))

})
