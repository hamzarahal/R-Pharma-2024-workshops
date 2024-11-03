####Exercise 1: Parameterized plots with ggplot2####
#Load the gapminder data:
library(gapminder)

#Create a variable to define a year in the gapminder data that you want to plot.

choose_year <- 1952

#use this new year variable

library(dplyr)
library(ggplot2)
library(glue)

# Median life expectancy per continent
gapminder_year <- gapminder |>
  filter(year == choose_year) |>
  group_by(continent) |>
  summarise(
    median_lifeExp = median(lifeExp)
  )

# Bar chart
ggplot(data = gapminder_year) +
  geom_col(
    mapping = aes(
      x = median_lifeExp,
      y = reorder(continent, median_lifeExp)
    )
  ) +
  labs(
    x = "Median Life Expectancy (years)", y = NULL,
    title = glue("Life Expectancy in {choose_year}")
  )

###Turn your code into a function that takes the data and year variable as arguments.

barchart_year <- function(choose_year, data = gapminder) {
  # Median life expectancy per continent
  gapminder_year <- gapminder |>
    filter(year == choose_year) |>
    group_by(continent) |>
    summarise(
      median_lifeExp = median(lifeExp)
    )
  # Bar chart
  g <- ggplot(data = gapminder_year) +
    geom_col(
      mapping = aes(
        x = median_lifeExp,
        y = reorder(continent, median_lifeExp)
      )
    ) +
    labs(
      x = "Median Life Expectancy (years)", y = NULL,
      title = glue("Life Expectancy in {choose_year}")
    )
  return(g)
}

#Check it works:

barchart_year(2002)

###Add another argument to your function that allows a user to define the bar colour.

barchart_year <- function(
    choose_year, fill = "blue", data = gapminder) {
  # Median life expectancy per continent
  gapminder_year <- gapminder |>
    filter(year == choose_year) |>
    group_by(continent) |>
    summarise(
      median_lifeExp = median(lifeExp)
    )
  # Bar chart
  g <- ggplot(data = gapminder_year) +
    geom_col(
      mapping = aes(
        x = median_lifeExp,
        y = reorder(continent, median_lifeExp)
      ),
      fill = fill
    ) +
    labs(
      x = "Median Life Expectancy (years)", y = NULL,
      title = glue("Life Expectancy in {choose_year}")
    )
  return(g)
}

barchart_year(2002, fill = "purple")


