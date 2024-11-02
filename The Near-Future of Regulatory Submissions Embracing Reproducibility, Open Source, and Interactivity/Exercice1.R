############Exercice1#####################

# Load necessary libraries
library(dplyr)

# Sample data frame with demographic data
set.seed(123)
data <- data.frame(
  id = 1:100,
  age = sample(18:80, 100, replace = TRUE),
  gender = sample(c("Male", "Female"), 100, replace = TRUE),
  treatment = sample(c("Treatment A", "Treatment B"), 100, replace = TRUE)
)

# Count participants per treatment group to get labels with counts
treatment_counts <- data |> 
  count(treatment) |> 
  mutate(treatment_label = paste0(treatment, " (N=", n, ")"))

# Create the demographic summary table
demographic_table <- data |> 
  # Join with treatment counts to include the labeled treatment names
  left_join(treatment_counts, by = "treatment") |>
  # Summarize age, female, and male counts and percentages by the labeled treatment
  group_by(treatment_label) |> 
  summarise(
    `Mean Age (SD)` = paste0(round(mean(age), 1), " (", round(sd(age), 1), ")"),
    `N Female (%)` = paste0(sum(gender == "Female"), " (", round(sum(gender == "Female") / n() * 100, 1), "%)"),
    `N Male (%)` = paste0(sum(gender == "Male"), " (", round(sum(gender == "Male") / n() * 100, 1), "%)"),
    .groups = "drop"
  ) |>
  # Transpose for easy review if needed
  t() |>
  print()