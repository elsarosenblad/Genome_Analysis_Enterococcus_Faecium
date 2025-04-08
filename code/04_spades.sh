#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 08:00:00
#SBATCH -J spades_hybrid
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

# Load SPAdes module on UPPMAX
module load bioinfo-tools
module load spades

# Input paths
ILLUMINA_R1=./analyses/02_preprocessing/illumina_trimmed/E745-1_trimmed_1_paired.fq.gz
ILLUMINA_R2=./analyses/02_preprocessing/illumina_trimmed/E745-1_trimmed_2_paired.fq.gz
NANOPORE_READS=./data/rawdata/nanopore/E745_all.fasta.gz 

# Output
OUTDIR=./analyses/03_spades_assembly
mkdir -p $OUTDIR

# Run SPAdes
spades.py \
  --pe1-1 $ILLUMINA_R1 \
  --pe1-2 $ILLUMINA_R2 \
  --nanopore $NANOPORE_READS \
  -k 77 \
  --only-assembler \
  -t 1 \
  -m 64 \
  -o $OUTDIR

