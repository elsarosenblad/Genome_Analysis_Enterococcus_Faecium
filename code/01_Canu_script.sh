#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 06:00:00
#SBATCH -J genome_assembly_pacbio
#SBATCH --mail-type=ALL
#SBATCH --mail-user elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load canu

# Correct relative paths based on your directory structure
INPUT_READS=./data/rawdata/pacbio/*.fastq.gz
OUTPUT_DIR=./analyses/genome_assembly_output
GENOME_SIZE=3m


# Run Canu
canu \
 -p genome_assembly \
 -d "$OUTPUT_DIR" \
 genomeSize=$GENOME_SIZE \
useGrid=false \
 -pacbio-raw $INPUT_READS
