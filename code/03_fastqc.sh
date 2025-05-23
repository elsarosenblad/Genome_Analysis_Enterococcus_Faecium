#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J fastqc_rnaseq_trim
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load required modules
module load bioinfo-tools
module load FastQC

# Define paths
TRIM_DIR=./analyses/08_transcriptomic_preprocessing/trimmed
OUT_DIR=./analyses/08_transcriptomic_preprocessing/fastqc_trim

mkdir -p $OUT_DIR/bhi $OUT_DIR/serum

fastqc -t 4 -o $OUT_DIR/bhi $TRIM_DIR/bh/*.fq.gz
fastqc -t 4 -o $OUT_DIR/serum $TRIM_DIR/serum/*.fq.gz
