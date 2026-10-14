# Read in data
background <- read.csv("data/background-clean.csv")
interest <- read.csv("data/interest-clean.csv")

# Combine the two datasets using response ID
combined_data <- merge(
  background,
  interest[, c("response_id", "type")],
  by = "response_id"
)

