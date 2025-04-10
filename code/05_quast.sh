#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J quast_comparison
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load quast

# Define paths to assemblies
CanuAssembly=analyses/01_canu_assembly/genome_assembly.contigs.fasta
SpadesAssembly=analyses/03_spades_assembly/contigs.fasta

# Output directory
OUTDIR=analyses/04_quast_evaluation
mkdir -p $OUTDIR

# Run QUAST for both assemblies
quast.py \
  -o $OUTDIR \
  -t 4 \
  -l "Canu,SPAdes" \
  $CanuAssembly $SpadesAssembly
