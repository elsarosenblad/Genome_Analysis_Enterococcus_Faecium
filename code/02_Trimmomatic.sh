#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 06:00:00
#SBATCH -J trimmomatic_rnaseq
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elsa.rosenblad.9391@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load trimmomatic

ADAPTERS=/sw/bioinfo/trimmomatic/0.39/snowy/adapters/TruSeq3-PE.fa
RAW_BASE=./data/rawdata
OUT_BASE=./analyses/08_transcriptomic_preprocessing/trimmed

mkdir -p $OUT_BASE/bhi $OUT_BASE/serum

# Function to run trimmomatic
run_trimmomatic () {
  SAMPLE=$1
  SOURCE=$2
  OUTDIR=$3

  fwd="${SOURCE}/trim_paired_${SAMPLE}_pass_1.fastq.gz"
  rev="${SOURCE}/trim_paired_${SAMPLE}_pass_2.fastq.gz"
  out_paired_fwd="${OUTDIR}/${SAMPLE}_R1_paired.fq.gz"
  out_unpaired_fwd="${OUTDIR}/${SAMPLE}_R1_unpaired.fq.gz"
  out_paired_rev="${OUTDIR}/${SAMPLE}_R2_paired.fq.gz"
  out_unpaired_rev="${OUTDIR}/${SAMPLE}_R2_unpaired.fq.gz"

  trimmomatic PE -threads 4 \
    "$fwd" "$rev" \
    "$out_paired_fwd" "$out_unpaired_fwd" \
    "$out_paired_rev" "$out_unpaired_rev" \
    ILLUMINACLIP:"$ADAPTERS":2:30:10 \
    LEADING:3 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:36
}

# Run on BHI samples
for sid in 1797972 1797973 1797974; do
  run_trimmomatic ERR${sid} "$RAW_BASE/RNA-Seq_BH" "$OUT_BASE/bhi"
done

# Run on Serum samples
for sid in 1797969 1797970 1797971; do
  run_trimmomatic ERR${sid} "$RAW_BASE/RNA-Seq_Serum" "$OUT_BASE/serum"
done

