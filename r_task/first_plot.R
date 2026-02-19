genes <- c("BRCA1", "TP53", "EGFR")
expression <- c(12.5, 45.2, 30.1)
condition <- c("Control", "Treatment", "Treatment")

exp_data <- data.frame(genes, expression, condition)

print("Structure of the data:")
str(exp_data)

png("r_task/expression_plot.png")
barplot(exp_data$expression, names.arg=exp_data$genes, main="Gene Expression", col="steelblue")
dev.off()

