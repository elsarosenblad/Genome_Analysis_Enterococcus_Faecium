import pandas as pd

# Load the file
df = pd.read_csv("DESeq2_results_serum_vs_bh.csv")  # or use sep="\t" if it's a .tsv file

# Optional: Check the first few rows to confirm column names
#print(df.head())

# Filter for significant DE genes
significant_genes = df[(df["padj"] < 0.001) & (df["log2FoldChange"].abs() > 1)]

# Count and percentage
total_genes = len(df)
num_significant = len(significant_genes)
percent = num_significant / total_genes * 100

print(f"Number of differentially expressed genes: {num_significant}")
print(f"Percentage of DE genes: {percent:.1f}%")
