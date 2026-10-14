# Read in data
background <- read.csv("data/background-clean.csv")
interest <- read.csv("data/interest-clean.csv")

# Combine the two datasets using response ID
combined_data <- merge(
  background,
  interest[, c("response_id", "type")],
  by = "response_id"
)

# Check project preference counts
table(combined_data$type)

# Create indicator for choosing industry
combined_data$industry <- combined_data$type == "ind"

# Define "strong" as advanced in all three areas
combined_data$all_strong <- combined_data$prog.prof == "adv" &
  combined_data$math.prof == "adv" &
  combined_data$stat.prof == "adv"

# Cross-tabulation
table(combined_data$all_strong, combined_data$industry)

# Proportion choosing industry within each group
prop.table(table(combined_data$all_strong, combined_data$industry), margin = 1)

# Fisher's exact test
fisher.test(table(combined_data$all_strong, combined_data$industry))

industry_prop <- tapply(
  combined_data$industry,
  combined_data$all_strong,
  mean
)

barplot(
  industry_prop,
  names.arg = c("Not advanced\nin all 3", "Advanced\nin all 3"),
  ylim = c(0, 1),
  ylab = "Proportion selecting industry",
  main = "Industry Project Preference by Self-Rated Proficiency"
)

combined_data$n_advanced <- 
  (combined_data$prog.prof == "adv") +
  (combined_data$math.prof == "adv") +
  (combined_data$stat.prof == "adv")

table(combined_data$n_advanced, combined_data$industry)

# Logistic regression
model <- glm(
  industry ~ n_advanced,
  data = combined_data,
  family = binomial
)

summary(model)

# Odds ratio
exp(coef(model))

# RESULTS
# 49 students total included in the analysis
# 32 students (65.3%) selected an industry project
# 11 students rated themselves as advanced in statistics, mathematics, & computing
#   Of those advanced in all 3 subjects, 54.5% (6 out of the 11) selected industry
#   Of students not advanced in all 3 subjects, 68.4% (26 out of the 38) selected   industry
# Fisher’s exact test: p = 0.4796, odds ratio =  0.5609028, 95% CI = [0.1151, 2.8180] --> indicating no statistically significant association
# Logistic regression: Each additional subject rated advanced was associated with an odds ratio of 0.8011 (p = 0.4397).
# Industry selection by number of subjects rated advanced: 0 subjects: 70.0% (7/10), 1 subject: 68.4% (13/19), 2 subjects: 66.7% (6/9), 3 subjects: 54.5% (6/11)