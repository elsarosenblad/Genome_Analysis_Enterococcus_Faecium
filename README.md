
## Transcriptomic Analysis of E. faecium E745 in Human Serum
This project analyses how the gene expression for Enterococcus faecium E745 differentiate between two conditions; human serum and the rich medium BHI. 

### Overview of analyses

All the scripts mentioned below can be found in the code folder.

**1. Genome assembly**
  - Assemble genome using Canu for PacBio reads, 01_Canu_script.sh
  - Illumina quality control and trimming using 03_fastqc.sh and 02_Trimmomatic.sh
  - Assemble genome using SPAdes for Illumina and NanoPore reads, 04_spades.sh
  - Evaluation using QUAST and MUMmerplots, 05_quast.sh and 06_mummer_canu.sh.

**2. Synteny Comparison and Genome Annotation**
  - Blast aligning using blastn followed by synteny comparison using visualization tool ACT, 08_ACT_blast.sh
  - Annotation of the Canu assembly using Prokka, 07_prokka_annotation.sh

**3. RNA Mapping and Counting**
  - Quality control of RNA Illumina reads (03_fastqc.sh) followed by mapping to the annotated genome using BWA, 09_BWA_nobackup.sh
  - Sort and indexing the SAM files usign SAMtools followed by gene quantification with HTSeq, 10_HTSeq.sh

**4. Differential Expression**
   - Differential Expression statistics/data generated using DESeq2
   - Result analyzed by using threasholds and plotting using pyhton packages matplotlib, sklearn.
  

   ### Structure of the github repository
   
The github consits of two main folders; code and data. The code folder cosits of 11 scripts and two subfolders; pyhton_scrips and DESeq2. The 11 scripts are numbered after creation and use except for 02_Trimmomatic.sh and 03_fastqc.sh which were reused during the project. The subfolder DESeq2 contains the R script used for the DE analysis and the batch script used to run it. The pyhton_scripts contains all the python scirpt used to create graphs and gather statistics used to analyze and visualize the result at the last step of the project. 

The data folder contains three subfolders; metadata, rawdata and referece_genome. The rawdata contains softlinks to the rawdata used in the project and the metadata folder contains a csv file with the metadata for the rawdata. The referece_genome fodlr contains the reference genome in two formats (fasta and gb) and the output from the blast alginment used for the synteny comparison.

The repository also contains the output folder analyses that is ignored by the .gitignore file. The reason for this is because some softwares results in large output that is not needed to be tracked.
