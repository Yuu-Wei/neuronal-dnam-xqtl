library(ivreg)

args <- commandArgs(trailingOnly = TRUE)

genotype_file <- args[1]
expression_file <- args[2]
methylation_file <- args[3]
out_prefix <- args[4]

genotype <- read.table(genotype_file, header = TRUE, row.names = 1, check.names = FALSE)
expression <- read.table(expression_file, header = TRUE, row.names = 1, check.names = FALSE)
methylation <- read.table(methylation_file, header = TRUE, row.names = 1, check.names = FALSE)

t.genotype <- t(genotype)
t.expression <- t(expression)
t.methylation <- t(methylation)

colnames(t.expression) <- "expression"
colnames(t.methylation) <- "methylation"

num.snp <- ncol(t.genotype)
colnames(t.genotype) <- paste0("snp", seq_len(num.snp))

dat <- as.data.frame(cbind(t.genotype, t.expression, t.methylation))

fit <- ivreg(
  as.formula(
    paste("expression ~ methylation |", paste(colnames(t.genotype), collapse = "+"))
  ),
  data = dat
)

write.table(summary(fit)$r.squared,
            paste0(out_prefix, ".R2.txt"),
            sep = "\t", quote = FALSE, col.names = FALSE, row.names = FALSE)

write.table(summary(fit)$adj.r.squared,
            paste0(out_prefix, ".adjusted_R2.txt"),
            sep = "\t", quote = FALSE, col.names = FALSE, row.names = FALSE)

write.table(summary(fit)$diagnostics,
            paste0(out_prefix, ".diagnostics.txt"),
            sep = "\t", quote = FALSE, col.names = TRUE, row.names = TRUE)

write.table(summary(fit)$coefficients,
            paste0(out_prefix, ".slope.txt"),
            sep = "\t", quote = FALSE, col.names = TRUE, row.names = TRUE)