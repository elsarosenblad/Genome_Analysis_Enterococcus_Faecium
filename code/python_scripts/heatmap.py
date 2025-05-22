import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler

# Load normalized or raw counts
df = pd.read_csv("merge_countfiles.tsv", sep="\t")
df = df[~df["gene_id"].str.startswith("__")]
df.set_index("gene_id", inplace=True)

# Transpose to genes x samples
df_t = df.T

# Calculate variance per gene
gene_variance = df_t.var(axis=0)

# Select top 50 most variable genes
top_genes = gene_variance.sort_values(ascending=False).head(50).index

# Subset original matrix (samples as rows)
df_top = df.loc[top_genes]

# Scale per gene (row)
scaled_data = StandardScaler().fit_transform(df_top.T)
scaled_df = pd.DataFrame(scaled_data, index=df_top.columns, columns=df_top.index)


plt.figure(figsize=(10, 8))
sns.clustermap(
    scaled_df,
    cmap="RdPu",
    col_cluster=True,
    row_cluster=True,
    linewidths=0.5,
    figsize=(12, 8)
)
plt.title("Heatmap of Top 50 Variable Genes", y=1.05)
plt.savefig("heatmap_top_variable_genes.png", dpi=300)
plt.show()
