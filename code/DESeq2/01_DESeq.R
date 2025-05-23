# Load library
library(DESeq2)

# Load merged count file
counts <- read.table("/home/elro9391/Genome_Analysis_Enterococcus_Faecium/analyses/08_readcount_htseq/merge_countfiles.tsv", header=TRUE, row.names=1, sep="\t")


# Define sample conditions
condition <- factor(c("bh", "bh", "bh", "serum", "serum", "serum"))

# Create sample metadata
col_data <- data.frame(row.names=colnames(counts), condition)

# Build DESeq2 dataset
dds <- DESeqDataSetFromMatrix(countData = counts, colData = col_data, design = ~ condition)

# Run differential expression
dds <- DESeq(dds)

# Extract results (Serum vs BH)
res <- results(dds)

# Save results
write.csv(as.data.frame(res), file = "DESeq2_results_serum_vs_bh.csv")

# order by p-value and save top results, NOT USED
res_ordered <- res[order(res$pvalue), ]
write.csv(as.data.frame(res_ordered), file = "DESeq2_results_ordered.csv")

