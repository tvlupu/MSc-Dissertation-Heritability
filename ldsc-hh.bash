#!/bin/sh

#$ -N hh-ldsc-mafdep            
#$ -cwd         
#$ -e /exports/eddie/scratch/s2583611/ldsc-exports
#$ -o /exports/eddie/scratch/s2583611/ldsc-exports
#$ -l h_vmem=15G
#$ -l rl9=true

. /etc/profile.d/modules.sh

module load anaconda
source activate ldsc

###############################################################################################

# STEP 1: standardise summary statistics (munge_sumstats)
cd /exports/eddie/scratch/s2583611/cleaned-sumstats/

for f in cleaned*.txt; do
python /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldsc/munge_sumstats.py --sumstats $f \
--a1 effect_allele --a2 non_effect_allele --snp variant_id --p pvalue --frq frequency \
--N 14692 \
--out /exports/eddie/scratch/s2583611/ldsc-outputs/sumstats.$f;
done 

###############################################################################################

# STEP 2: run LDSC for regression intercept and SNP heritability

cd /exports/eddie/scratch/s2583611/ldsc-outputs/
# --w-ld and --ref-ld are the same file, i.e. the (full genome, not /chr) reference LD scores calculated from 1000G without Finnish individuals

for f in sumstats.cleaned*sumstats.gz; do
python /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldsc/ldsc.py --h2 $f \
--w-ld /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldsc/ref --ref-ld /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldsc/ref \
--out hh_$f;
done

###############################################################################################