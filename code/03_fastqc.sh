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

# Define paths
TRIMMED_DIR=./analyses/02_preprocessing/illumina_trimmed
FASTQC_OUT=./analyses/02_preprocessing/fastqc_trim

fastqc -t 2 -o $FASTQC_OUT \
  $TRIMMED_DIR/E745-1_trimmed_1_paired.fq.gz \
  $TRIMMED_DIR/E745-1_trimmed_2_paired.fq.gz