# Question 1: Does programming-language preference relate to domain interests?

# join the datasets
background <- read.csv("data/background-clean.csv")
interest <- read.csv("data/interest-clean.csv")
join <- merge(background, interest, by = "response_id")


table(join$language)
# No preference        Python             R 
# 16                   22                11 


# Split student's list of domain interests
domain_list <- strsplit(join$domains, ", ", fixed = TRUE)
domains <- sort(unique(unlist(domain_list)))

# Proportion selecting each domain within each language group
domain_prop <- sapply(domains, function(domain) {
  selected <- sapply(domain_list, function(x) domain %in% x)
  tapply(selected, join$language, mean)
})
round(domain_prop, 2)

# Bar chart of domain interests by language preference
old_par <- par(mar = c(5, 14, 4, 2))
barplot(
  domain_prop,
  beside = T, horiz = T, las = 1,
  col = c("red", "blue", "grey"),
  xlim = c(0, 1),
  xlab = "Proportion within language group",
  main = "Domain Interests by Language Preference"
)
legend("topright", legend = rownames(domain_prop),
       fill = c("red", "blue", "grey"), bty = "n", cex = 0.8)
par(old_par)


# Count how many domains each student selected and save it as n_domains
join$n_domains <- lengths(domain_list)

#average number of domains selected for each language group
aggregate(n_domains ~ language, data = join, FUN = mean)
#median of domains selected for each language
aggregate(n_domains ~ language, data = join, FUN = median)


# Compare the distribution of domain counts across language groups
boxplot(
  n_domains ~ language, data = join,
  col = c("red", "blue", "grey"),
  xlab = "Language preference", ylab = "Number of domains selected",
  main = "Breadth of Interests by Language Preference"
)



# RESULTS
# 49 students in total: No preference = 16, Python = 22, R = 11.
# Mean domains selected for each preferred language: No preference = 5.06, Python = 3.95, R = 3.36.
# Median domains selected for each preferred language: No preference = 5, Python = 4, R = 4.
# Domain counts differ across groups; No preference has the highest average.(from box plot)

#INSIGHT
#students with no language preference may have a broader range of domain interests.
#evidence 1: The No preference group selected an average of 5.06 domains, compared with 3.95 for Python and 3.36 for R.
#evidence 2: From our data, the students with no preferred language shows higher interest in public health, biology, and social or political science. 
#However, this pattern is not as strong for hot domain like Technology and Soft ware development, which have high portion of students from all three language group. 
