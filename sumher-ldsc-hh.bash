#!/bin/sh
# Grid Engine options (lines prefixed with #$)
#$ -N ldsc-humdef-hh            
#$ -cwd       
#$ -e /exports/eddie/scratch/s2583611/irl-exports
#$ -o /exports/eddie/scratch/s2583611/irl-exports           
#$ -l h_rt=05:00:00 
#$ -l h_vmem=32G
#$ -l rl9=true


cd /exports/eddie/scratch/s2583611/irl-outputs

# no need to unzip .gz file or rename files since sumher-hh was already run and .txt files for the summary statistics are already available

# calculate h2
for f in cleaned.t2d-new.txt; do
/gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldak/ldak5.2.linux \
--sum-hers ldsc-humandef.$f --summary $f \
--tagfile /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldak/HumDef-ldsc.tagging \      # applies the tagging file with the LDSC version of SumHer
--intercept YES --check-sums NO --max-threads 20;
done