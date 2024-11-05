###########Exercice4

##1.Render a version of your report for the year 1972 using the quarto_render() function.

quarto_render(
  input = "report.qmd",
  execute_params = list(choose_year = 1972)
)

##2.Render a version of your report for all years in the data.

walk(
  .x = unique(gapminder$year),
  .f = ~quarto_render(
    input = "report.qmd",
    output_file = glue("report_{.x}.html"),
    execute_params = list(
      choose_year = .x
    )
  )
)


