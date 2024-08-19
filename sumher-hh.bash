#!/bin/sh
# Grid Engine options (lines prefixed with #$)
#$ -N sumher-mafdep             
#$ -cwd       
#$ -e /exports/eddie/scratch/s2583611/ldak-exports
#$ -o /exports/eddie/scratch/s2583611/ldak-exports           
#$ -l h_rt=02:00:00 
#$ -l h_vmem=15G
#$ -l rl9=true


cd /exports/eddie/scratch/s2583611/ldsc-outputs

# convert cleaned LDSC .gz files to .txt
for f in ; do
gunzip -c $f > /exports/eddie/scratch/s2583611/ldak-outputs/$f.txt;
done

# rename to sumstats.cleaned-snp_MAF.txt
cd /exports/eddie/scratch/s2583611/ldak-outputs

for f in *gz.txt*; do mv -- "$f" "sumher.$(${f//cleaned.sumstats/})"; done    # removes "cleaned.sumstats" at the start of the file name and replaces with "sumher"
for f in *gz.txt*; do mv -- "$f" "${f//.txt/fastGWA.sumstats.gz/}"; done    # remove ".txt/fastGWA.sumstats.gz" regardless of how many characters come after it/what they are


# calculate h2
for f in sumstats.cleaned*.txt; do
/gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldak/ldak5.2.linux --sum-hers sumher.$f \
--summary $f --tagfile /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldak/HumDef.tagging \
--intercept YES --check-sums NO --max-threads 20;
done
