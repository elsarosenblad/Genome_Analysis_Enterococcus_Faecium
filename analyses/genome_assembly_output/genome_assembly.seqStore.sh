#!/bin/sh


#  Path to Canu.

bin="/sw/bioinfo/canu/2.2/rackham/bin"

#  Report paths.

echo ""
echo "Found perl:"
echo "  " `which perl`
echo "  " `perl --version | grep version`
echo ""
echo "Found java:"
echo "  " `which /sw/comp/java/x86_64/sun_jdk1.8.0_151/bin/java`
echo "  " `/sw/comp/java/x86_64/sun_jdk1.8.0_151/bin/java -showversion 2>&1 | head -n 1`
echo ""
echo "Found canu:"
echo "  " $bin/canu
echo "  " `$bin/canu -version`
echo ""


#  Environment for any object storage.

export CANU_OBJECT_STORE_CLIENT=
export CANU_OBJECT_STORE_CLIENT_UA=
export CANU_OBJECT_STORE_CLIENT_DA=
export CANU_OBJECT_STORE_NAMESPACE=
export CANU_OBJECT_STORE_PROJECT=





/sw/bioinfo/canu/2.2/rackham/bin/sqStoreCreate \
  -o ./genome_assembly.seqStore.BUILDING \
  -minlength 1000 \
  -genomesize 3000000 \
  -coverage   200 \
  -bias       0 \
  -raw -pacbio m131023_233432_42174_c100519312550000001823081209281335_s1_X0.1.subreads /crex/proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.1.subreads.fastq.gz \
  -raw -pacbio m131023_233432_42174_c100519312550000001823081209281335_s1_X0.2.subreads /crex/proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.2.subreads.fastq.gz \
  -raw -pacbio m131023_233432_42174_c100519312550000001823081209281335_s1_X0.3.subreads /crex/proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.3.subreads.fastq.gz \
  -raw -pacbio m131024_200535_42174_c100563672550000001823084212221342_s1_p0.1.subreads /crex/proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.1.subreads.fastq.gz \
  -raw -pacbio m131024_200535_42174_c100563672550000001823084212221342_s1_p0.2.subreads /crex/proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.2.subreads.fastq.gz \
  -raw -pacbio m131024_200535_42174_c100563672550000001823084212221342_s1_p0.3.subreads /crex/proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.3.subreads.fastq.gz \
&& \
mv ./genome_assembly.seqStore.BUILDING ./genome_assembly.seqStore \
&& \
exit 0

exit 1
