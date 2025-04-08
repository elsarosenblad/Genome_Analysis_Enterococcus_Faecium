#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J fastqc_illumina
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load required modules
module load bioinfo-tools
module load FastQC

# Define directories
RAW_DIR=./data/rawdata/illumina
TRIMMED_DIR=./analyses/02_preprocessing/trimming
FASTQC_RAW_OUT=./analyses/02_preprocessing/fastqc_raw
FASTQC_TRIM_OUT=./analyses/02_preprocessing/fastqc_trim

# Create output directories if not existing
mkdir -p $FASTQC_RAW_OUT
mkdir -p $FASTQC_TRIM_OUT

# Run FastQC on raw reads
echo "Running FastQC on raw reads..."
fastqc -t 2 -o $FASTQC_RAW_OUT $RAW_DIR/*.fq.gz

# Run FastQC on trimmed reads
echo "Running FastQC on trimmed reads..."
fastqc -t 2 -o $FASTQC_TRIM_OUT $TRIMMED_DIR/*.fq.gz

echo "FastQC analysis complete."
