###########Exercise 2:Build a demographic table using {rtables} or {gtsummary}.######

adsl <- random.cdisc.data::cadsl
advs <- random.cdisc.data::cadvs

# Pre-Processing - Add any variables needed in your table to df
adsl <- adsl |> 
  mutate(AGEGR1 = as.factor(case_when(
    AGE >= 17 & AGE < 65 ~ "≥17 to &lt;65",
    AGE >= 65 ~ "≥65",
    AGE >= 65 & AGE < 75 ~ "≥65 to &lt;75",
    AGE >= 75 ~ "≥75"
  )))

advs <- advs |> 
  filter(AVISIT == "BASELINE", VSTESTCD == "TEMP") |>
  select("USUBJID", "AVAL")

anl <- left_join(adsl, advs, by = "USUBJID")

df <- anl |>
  df_explicit_na()

vars <- c("SEX", "AGE", "AGEGR1", "RACE", "ETHNIC", "COUNTRY")
lbl_vars <- formatters::var_labels(df, fill = TRUE)[vars]

lyt <- basic_table(show_colcounts = TRUE) |>
  split_cols_by("ARM", split_fun = add_overall_level("Total Population", first = FALSE)) |>
  analyze_vars(
    vars = vars,
    var_labels = lbl_vars,
    show_labels = "visible",
    .stats = c("mean_sd", "median_range", "count_fraction"),
    .formats = NULL,
    na.rm = FALSE
  ) |>
  append_topleft("Characteristic")

tbl <- build_table(lyt, df = df) |> 
  prune_table()

tbl
