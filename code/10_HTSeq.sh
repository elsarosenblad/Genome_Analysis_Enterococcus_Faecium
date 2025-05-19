#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J htseq_counting_final
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x_%j.out

# Load modules
module load bioinfo-tools
module load htseq/2.0.2

# Paths
GFF_FILE="/home/elro9391/Genome_Analysis_Enterococcus_Faecium/analyses/06_annotation/E745_annotation_clean_fixed.gff"

OUTPUT_DIR="/home/elro9391/Genome_Analysis_Enterococcus_Faecium/analyses/10_readcount_htseq/mapped_counts"
mkdir -p "$OUTPUT_DIR/bh"
mkdir -p "$OUTPUT_DIR/serum"

# Loop through BH samples
for BAM in /proj/uppmax2025-3-3/nobackup/elro9391/mapped_bams/bh/*.bam; do
    BASENAME=$(basename "$BAM" _mapped.bam)

    htseq-count \
        --format=bam \
        --order=pos \
        --type=CDS \
        --idattr=locus_tag \
        --mode=union \
        --stranded=reverse \
        "$BAM" "$GFF_FILE" > "$OUTPUT_DIR/bh/${BASENAME}_counts.txt"
done

# Loop through Serum samples
for BAM in /proj/uppmax2025-3-3/nobackup/elro9391/mapped_bams/serum/*.bam; do
    BASENAME=$(basename "$BAM" _mapped.bam)

    htseq-count \
        --format=bam \
        --order=pos \
        --type=CDS \
        --idattr=locus_tag \
        --mode=union \
        --stranded=reverse \
        "$BAM" "$GFF_FILE" > "$OUTPUT_DIR/serum/${BASENAME}_counts.txt"
done

echo "HTSeq-count finished successfully ✅"

