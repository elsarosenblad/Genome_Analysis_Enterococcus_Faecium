#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J mummer_canu
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load MUMmer
module load bioinfo-tools
module load MUMmer/4.0.0beta2

# Define input files
REF=./data/reference_genome/E745_reference.fasta
QUERY=./analyses/01_canu_assembly/genome_assembly.contigs.fasta.gz
OUTDIR=./analyses/05_mummer_canu
mkdir -p $OUTDIR
cd $OUTDIR

# Align query to reference
nucmer --prefix=canu_vs_ref $REF $QUERY

# Filter for best alignments (1-to-1 mapping)
delta-filter -1 canu_vs_ref.delta > canu_vs_ref.filtered.delta

# Generate plot
mummerplot --png --layout --filter \
  --prefix=canu_vs_ref_plot canu_vs_ref.filtered.delta


