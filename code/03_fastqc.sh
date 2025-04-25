#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J fastqc_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load required modules
module load bioinfo-tools
module load FastQC

# Define paths
BH_DIR=./data/rawdata/RNA-Seq_BH
SERUM_DIR=./data/rawdata/RNA-Seq_Serum
FASTQC_OUT=./analyses/08_fastqc_rnaseq_raw

mkdir -p $FASTQC_OUT

fastqc -t 4 -o $FASTQC_OUT $BH_DIR/*.fastq.gz
fastqc -t 4 -o $FASTQC_OUT $SERUM_DIR/*.fastq.gz
