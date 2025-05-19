# Load libraries
library(ggplot2)
library(dplyr)

# Load DESeq2 result file
results <- read.csv("../DESeq2_results_serum_vs_bh.csv", sep = ";")

# Mark significance and calculate -log10(padj)
results$significant <- with(results, padj < 0.05 & abs(log2FoldChange) > 1)
results$negLog10Padj <- -log10(results$padj)

# ---- Volcano Plot ----
volcano <- ggplot(results, aes(x = log2FoldChange, y = negLog10Padj)) +
  geom_point(aes(color = significant), alpha = 0.7) +
  scale_color_manual(values = c("FALSE" = "gray", "TRUE" = "red")) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "blue") +
  labs(
    title = "Volcano Plot: Serum vs. BHI",
    x = "Log2 Fold Change",
    y = "-Log10 Adjusted p-value"
  ) +
  theme_minimal()

ggsave("volcano_plot.png", volcano, width = 8, height = 6, dpi = 300)

# ---- MA Plot ----
ma <- ggplot(results, aes(x = log10(baseMean + 1), y = log2FoldChange)) +
  geom_point(aes(color = significant), alpha = 0.6) +
  scale_color_manual(values = c("FALSE" = "gray", "TRUE" = "red")) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(
    title = "MA Plot: Serum vs. BHI",
    x = "Log10 Base Mean Expression",
    y = "Log2 Fold Change"
  ) +
  theme_minimal()

ggsave("ma_plot.png", ma, width = 8, height = 6, dpi = 300)

