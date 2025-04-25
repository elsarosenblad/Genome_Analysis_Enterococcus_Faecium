#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J blast_act
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=blast_act_%j.out

# Load required modules
module load bioinfo-tools
module load blast

# Define paths
REFERENCE=data/reference_genome/E745_reference.fasta
QUERY=analyses/06_annotation/E745_annotation.gbk

# The name of the BLAST database that will be created
DB=data/reference_genome/E745_reference_db

# Where the BLAST alignment output will be saved
OUTFILE=analyses/07_act/blast_comparison.tab

# Create output folder if needed
mkdir -p analyses/07_act

# Make BLAST database from reference
makeblastdb -in $REFERENCE -dbtype nucl -out $DB

# Run BLAST to compare query genome to reference
blastn -query $QUERY \
       -db $DB \
       -out $OUTFILE \
       -outfmt 6


