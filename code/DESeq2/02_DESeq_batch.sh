#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J DESeq2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=DESeq2_analysis.%j.out
#SBATCH --error=DESeq2_analysis.%j.err

module load bioinfo-tools
module load R/4.3.1
module load R_packages/4.3.1

cd /home/elro9391/Genome_Analysis_Enterococcus_Faecium/code/
Rscript 12_DESeq.R
