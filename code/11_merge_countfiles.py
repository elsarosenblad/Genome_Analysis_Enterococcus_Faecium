import os
import pandas as pd

# Updated base directory
counts_dir = "/home/elro9391/Genome_Analysis_Enterococcus_Faecium/analyses/08_readcount_htseq"

# Collect all .txt files from both folders
count_files = []
for subfolder in ["bhi", "serum"]:
    sub_path = os.path.join(counts_dir, subfolder)
    for file in os.listdir(sub_path):
        if file.endswith("_counts.txt"):
            count_files.append(os.path.join(sub_path, file))

# Merge all count files
merged_df = None

for file in sorted(count_files):
    sample_name = os.path.basename(file).replace("_counts.txt", "")
    df = pd.read_csv(file, sep="\t", header=None, names=["gene_id", sample_name])
    df = df[~df["gene_id"].str.startswith("__")]  # Remove __no_feature etc.
    df.set_index("gene_id", inplace=True)

    if merged_df is None:
        merged_df = df
    else:
        merged_df = merged_df.join(df, how="outer")

# Fill missing values with 0 and convert to integers
merged_df = merged_df.fillna(0).astype(int)

# Save merged table
output_file = os.path.join(counts_dir, "DESeq2_ready_counts.tsv")
merged_df.to_csv(output_file, sep="\t")

print(f"✅ Merged count matrix saved to: {output_file}")

