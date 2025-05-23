#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 06:00:00
#SBATCH -J mapping_to_nobackup
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=mapping_to_nobackup_%j.out

# Load modules
module load bioinfo-tools
module load bwa
module load samtools

# Paths
GENOME="./analyses/01_canu_assembly/genome_assembly.contigs.fasta"
OUTDIR="/proj/uppmax2025-3-3/nobackup/elro9391/mapped_bams"
mkdir -p "$OUTDIR/bhi"
mkdir -p "$OUTDIR/serum"

# Index the genome if not already indexed
if [ ! -f "${GENOME}.bwt" ]; then
    bwa index "$GENOME"
fi

# Mapping function
map_sample() {
  SAMPLE=$1
  SRC=$2
  DEST=$3

  bwa mem -t 4 "$GENOME" \
    "$SRC/trim_paired_${SAMPLE}_pass_1.fastq.gz" \
    "$SRC/trim_paired_${SAMPLE}_pass_2.fastq.gz" | \
  samtools view -@ 4 -Sb - | \
  samtools sort -@ 4 -T "$DEST/tmp_${SAMPLE}" -o "$DEST/${SAMPLE}_mapped.bam" -

  samtools index "$DEST/${SAMPLE}_mapped.bam"
}

# BHI Samples
for sid in 1797972 1797973 1797974; do
  map_sample ERR${sid} ./data/rawdata/RNA-Seq_BH "$OUTDIR/bhi"
done

# Serum Samples
for sid in 1797969 1797970 1797971; do
  map_sample ERR${sid} ./data/rawdata/RNA-Seq_Serum "$OUTDIR/serum"
done

echo "Mapping to nobackup finished successfully ✅"

