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
combined_data$industry <- dat$type == "ind"

# Define "strong" as advanced in all three areas
combined_data$all_strong <- dat$prog.prof == "adv" &
  dat$math.prof == "adv" &
  dat$stat.prof == "adv"

# Cross-tabulation
table(combined_data$all_strong, combined_data$industry)

