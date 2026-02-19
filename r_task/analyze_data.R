data <- read.csv("r_task/sample_data.csv")

mean_score <- mean(data$Score)
print(paste("Average Score:", mean_score))

treatment_group <- subset(data, Group == "Treatment")
max_score_treatment <- max(treatment_group$Score)
print(paste("Max Score in Treatment:", max_score_treatment))

png("r_task/score_boxplot.png")
boxplot(Score ~ Group, data = data, main = "Score Distribution by Group", col = c("orange", "lightblue"))
dev.off()
