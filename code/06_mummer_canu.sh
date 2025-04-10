#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J mummer_canu
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load necessary modules
module load bioinfo-tools
module load MUMmer/4.0.0beta2

# Define full absolute paths
REF="/domus/h1/elro9391/Genome_Analysis_Enterococcus_Faecium/data/reference_genome/E745_reference.fasta"
QUERY="/domus/h1/elro9391/Genome_Analysis_Enterococcus_Faecium/analyses/01_canu_assembly/genome_assembly.contigs.fasta"

# Create output dir if not exists
OUTDIR="./analyses/05_mummer_canu"
mkdir -p $OUTDIR
cd $OUTDIR

# Run MUMmer
nucmer --prefix=canu_vs_ref "$REF" "$QUERY"

# Create plot
mummerplot --png --fat --large --layout -p canu_vs_ref canu_vs_ref.filtered.delta
