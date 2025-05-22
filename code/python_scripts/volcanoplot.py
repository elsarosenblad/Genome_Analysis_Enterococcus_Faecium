import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Load data
df = pd.read_csv("DESeq2_results_serum_vs_bh.csv", sep=",")
df = df.dropna(subset=["padj", "log2FoldChange"])
df["-log10(padj)"] = -np.log10(df["padj"])

# Classify each gene
def classify_gene(row):
    if row["padj"] < 0.001 and row["log2FoldChange"] > 1:
        return "Up-regulated"
    elif row["padj"] < 0.001 and row["log2FoldChange"] < -1:
        return "Down-regulated"
    else:
        return "Not significant"

df["category"] = df.apply(classify_gene, axis=1)

# Plot
plt.figure(figsize=(10, 6))
sns.scatterplot(
    data=df,
    x="log2FoldChange",
    y="-log10(padj)",
    hue="category",
    hue_order=["Up-regulated", "Down-regulated", "Not significant"],  # <-- control order here
    palette={
        "Up-regulated": "lightpink",
        "Down-regulated": "thistle",
        "Not significant": "gray"
    },
    alpha=0.7,
    edgecolor="black",       # <-- Add this
    linewidth=0.3            # Optional: thinner borders
)

# Reference lines
plt.axhline(-np.log10(0.001), color="black", linestyle="--")
plt.axvline(-1, color="black", linestyle="--")
plt.axvline(1, color="black", linestyle="--")

# Customize
plt.title("Expression in Serum compared to BHI Volcano Plot")
plt.xlabel("Log2 Fold Change")
plt.ylabel("-Log10 Adjusted p-value")
plt.xlim(-9, 9)
plt.ylim(-10, 250)
#plt.legend(title="Gene Regulation", loc="upper right")
plt.legend(
    title="Gene Regulation",
    bbox_to_anchor=(1.05, 1),
    loc='upper left',
    borderaxespad=0.
)

plt.tight_layout()
plt.savefig("volcano_plot_colored_by_condition.png", dpi=300)
plt.show()
