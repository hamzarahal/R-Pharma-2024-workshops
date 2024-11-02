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

