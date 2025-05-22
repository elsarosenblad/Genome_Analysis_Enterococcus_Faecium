import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load raw count data
df = pd.read_csv("merge_countfiles.tsv", sep="\t")

# Remove non-gene rows
df = df[~df["gene_id"].str.startswith("__")]

# Sum counts per gene across all samples
df["total_counts"] = df.iloc[:, 1:].sum(axis=1)

# Count categories
total = len(df)
expressed = len(df[df["total_counts"] >= 10])
weakly = len(df[(df["total_counts"] > 0) & (df["total_counts"] < 10)])
not_expressed = len(df[df["total_counts"] == 0])

# Filter for zoomed-in view
low_counts = df[df["total_counts"] <= 100]

# Create figure with two subplots side by side
fig, axes = plt.subplots(1, 2, figsize=(16, 6))

# Plot full histogram
axes[0].hist(df["total_counts"], bins=100, color="thistle", edgecolor="black", log=True)
axes[0].set_xlabel("Total counts per gene")
axes[0].set_ylabel("Number of genes (log scale)")
axes[0].set_title("Distribution of Read Counts per Gene")

# Plot zoomed-in histogram
axes[1].hist(low_counts["total_counts"], bins=50, color="thistle", edgecolor="black")
axes[1].set_xlabel("Total counts per gene (0–100)")
axes[1].set_ylabel("Number of genes")
axes[1].set_title("Zoomed-In: Genes with Low Read Counts (≤100)")

# Create annotation text
summary = (
    f"Total genes: {total}\n"
    f"Expressed (≥10): {expressed} ({expressed/total:.1%})\n"
    f"Weakly expressed (1–9): {weakly} ({weakly/total:.1%})\n"
    f"Not expressed (0): {not_expressed} ({not_expressed/total:.1%})"
)

# Add text box annotation to second plot
axes[1].text(
    55, max(np.histogram(low_counts["total_counts"], bins=50)[0]) * 0.8,
    summary,
    bbox=dict(boxstyle="round", facecolor="white", edgecolor="black"),
    fontsize=10
)

plt.tight_layout()
plt.savefig("combined_gene_count_histograms.png", dpi=300)
plt.show()
