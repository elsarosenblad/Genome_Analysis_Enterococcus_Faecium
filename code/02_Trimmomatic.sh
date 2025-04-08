#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 06:00:00
#SBATCH -J trimmomatic_illumina
#SBATCH --mail-type=ALL
#SBATCH --mail-user elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load trimmomatic

# Input and Output
READS_DIR=./data/rawdata/illumina
OUTPUT_DIR=./analyses/illumina_trimmed
ADAPTERS=/sw/bioinfo/trimmomatic/0.39/snowy/adapters/TruSeq3-PE.fa
mkdir -p $OUTPUT_DIR

# Input file names
FORWARD=E745-1.L500_SZXAPI015146-56_1_clean.fq.gz
REVERSE=E745-1.L500_SZXAPI015146-56_2_clean.fq.gz


# Output file names
TRIMMED_FWD_PAIRED=$OUT_DIR/E745_trimmed_R1_paired.fq.gz
TRIMMED_FWD_UNPAIRED=$OUT_DIR/E745_trimmed_R1_unpaired.fq.gz
TRIMMED_REV_PAIRED=$OUT_DIR/E745_trimmed_R2_paired.fq.gz
TRIMMED_REV_UNPAIRED=$OUT_DIR/E745_trimmed_R2_unpaired.fq.gz


# Run Trimmomatic on your Illumina paired-end data
trimmomatic PE -threads 1 \
 "$READS_DIR/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz" "$READS_DIR/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz" \
 "$OUTPUT_DIR/E745-1_trimmed_1_paired.fq.gz" "$OUTPUT_DIR/E745-1_trimmed_1_unpaired.fq.gz" \
 "$OUTPUT_DIR/E745-1_trimmed_2_paired.fq.gz" "$OUTPUT_DIR/E745-1_trimmed_2_unpaired.fq.gz" \
 ILLUMINACLIP:"$ADAPTERS":2:30:10 \
 LEADING:3 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:36
