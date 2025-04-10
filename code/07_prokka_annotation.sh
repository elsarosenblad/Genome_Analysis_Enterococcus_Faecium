#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 04:00:00
#SBATCH -J prokka_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=prokka_%j.out

# Load modules
module load bioinfo-tools
module load prokka

# Define input and output
INPUT=analyses/01_canu_assembly/genome_assembly.contigs.fasta
OUTDIR=analyses/06_annotation
PREFIX=E745_annotation

# Create output directory
mkdir -p $OUTDIR

# Run Prokka
prokka --outdir $OUTDIR --prefix $PREFIX --force $INPUT
