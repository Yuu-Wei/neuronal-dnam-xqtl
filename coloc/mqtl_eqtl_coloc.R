library(coloc)

args <- commandArgs(trailingOnly = TRUE)

mqtl_file <- args[1]
eqtl_file <- args[2]
out_prefix <- args[3]

mqtl <- read.table(mqtl_file, sep = "\t", header = FALSE)
eqtl <- read.table(eqtl_file, sep = "\t", header = FALSE)

colnames(mqtl) <- c("beta", "varbeta", "snp", "position", "pvalue", "N", "MAF")
colnames(eqtl) <- c("beta", "varbeta", "snp", "position", "pvalue", "N", "MAF")

mqtl$type <- "quant"
eqtl$type <- "quant"

mqtl <- mqtl[mqtl$varbeta != 0, ]
eqtl <- eqtl[eqtl$varbeta != 0, ]

check_dataset(mqtl, warn.minp = 1e-10)
check_dataset(eqtl, warn.minp = 1e-10)

res <- coloc.abf(dataset1 = mqtl, dataset2 = eqtl)

coloc_snp <- subset(res$results, SNP.PP.H4 > 0.01)
coloc_snp <- coloc_snp[order(coloc_snp$SNP.PP.H4, decreasing = TRUE), ]

write.table(coloc_snp, paste0(out_prefix, ".coloc_snp_PP4.txt"),
            quote = FALSE, col.names = TRUE, row.names = FALSE, sep = "\t")

write.table(res$summary, paste0(out_prefix, ".summary.txt"),
            quote = FALSE, col.names = FALSE, row.names = TRUE, sep = "\t")

print(res)