import pandas as pd
import numpy as np

# === INPUT FILES ===
deseq_file = "DESeq2_results_serum_vs_bh.csv"  # Your DESeq2 CSV file
gff_file = "E745_annotation_clean_fixed.gff"            # Your Prokka .gff annotation file

# === LOAD DESEQ2 RESULTS ===
df = pd.read_csv(deseq_file, sep=",", header=0)
df.rename(columns={df.columns[0]: "gene"}, inplace=True)
df = df.dropna(subset=["padj", "log2FoldChange"])
df["padj"] = df["padj"].clip(lower=1e-300)  # prevent log10(0)
df["-log10(padj)"] = -np.log10(df["padj"])

# === FILTER & SORT ===
significant_genes = df[
    (df["padj"] < 0.001) & (df["log2FoldChange"].abs() > 1)
].copy()

# === Top 50 most significant DE genes (up OR down) ===
top50 = significant_genes.sort_values("padj").head(50)

# === LOAD PROKKA GFF & PARSE ===
gff = pd.read_csv(
    gff_file,
    sep="\t",
    comment="#",
    header=None,
    names=["seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes"]
)

# Keep only CDS entries
gff = gff[gff["type"] == "CDS"]

# Extract gene name and product
def parse_attributes(attr_string):
    attrs = {}
    for item in attr_string.split(";"):
        if "=" in item:
            key, value = item.split("=", 1)
            attrs[key] = value
    return pd.Series({
        "gene": attrs.get("locus_tag", None),
        "product": attrs.get("product", "Unknown")
    })

gff_parsed = gff["attributes"].apply(parse_attributes)
gff_combined = pd.concat([gff.reset_index(drop=True), gff_parsed], axis=1)

top50_annotated = pd.merge(top50, gff_combined[["gene", "product"]], on="gene", how="left")

# === PRINT RESULTS ===


print("\n=== Top 50 Most Differentially Expressed Genes (Annotated) ===")
print(top50_annotated[["gene", "log2FoldChange", "padj", "product"]])

# === OPTIONAL: SAVE TO CSV ===
#top40_annotated.to_csv("top40_up_down_annotated.csv", index=False)
