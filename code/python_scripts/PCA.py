import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import seaborn as sns

# Load your RNA-seq count data
df = pd.read_csv("merge_countfiles.tsv", sep="\t")

# Remove non-gene rows
df = df[~df["gene_id"].str.startswith("__")]

# Set gene_id as index
df.set_index("gene_id", inplace=True)

# Transpose: samples as rows, genes as columns
df_t = df.T
df_t.index.name = "Sample"
df_t.reset_index(inplace=True)

# Manually assign conditions to each sample
sample_condition_map = {
    "ERR1797969": "Serum",
    "ERR1797970": "Serum",
    "ERR1797971": "Serum",
    "ERR1797972": "BHI",
    "ERR1797973": "BHI",
    "ERR1797974": "BHI"
}
df_t['Condition'] = df_t['Sample'].map(sample_condition_map)

# Separate metadata and expression data
conditions = df_t[['Sample', 'Condition']]
df_t.set_index("Sample", inplace=True)
df_numeric = df_t.drop(columns=["Condition"])  # keep only numeric values

# Standardize the data
scaler = StandardScaler()
scaled_data = scaler.fit_transform(df_numeric)

# Perform PCA
pca = PCA(n_components=2)
pca_result = pca.fit_transform(scaled_data)

# Create DataFrame for plotting
pca_df = pd.DataFrame(data=pca_result, columns=['PC1', 'PC2'])
pca_df['Sample'] = df_numeric.index
pca_df = pca_df.merge(conditions, on="Sample")

# Plot
plt.figure(figsize=(8, 6))
sns.scatterplot(
    data=pca_df,
    x="PC1", y="PC2",
    hue="Condition",  # Use BHI/Serum here
    palette={"BHI": "thistle", "Serum": "lightpink"},
    s=100,
    edgecolor="black",   # Add black borders
    linewidth=0.5        # Thin border
)
plt.title("PCA of RNA-seq Samples")
plt.xlabel(f"PC1 ({pca.explained_variance_ratio_[0]*100:.1f}% variance)")
plt.ylabel(f"PC2 ({pca.explained_variance_ratio_[1]*100:.1f}% variance)")
plt.legend(title="Condition")
plt.grid(True)
plt.tight_layout()
plt.savefig("PCA_colored_by_condition.png", dpi=300)
plt.show()
