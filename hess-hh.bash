#!/bin/sh

#$ -N hess-mafdep-hh              
#$ -cwd        
#$ -e /exports/eddie/scratch/s2583611/hess-exports
#$ -o /exports/eddie/scratch/s2583611/hess-exports
           
#$ -l h_rt=12:00:00 
#$ -l h_vmem=32G
#$ -pe sharedmem 10

#$ -l rl9=true
#$ -m bea -M s2583611@ed.ac.uk


cd /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/

. /etc/profile.d/modules.sh

module load anaconda

#conda create -n testhess python=2.7 numpy pandas scipy  - done only once in the command line
conda activate testhess
#conda install -n testhess pysnptools  - done only once in the command line


###############################################################################################

# to set up files

# before running this .bash, 
# reordered cols for HESS using the script prep-hess.bash
# so that column names are [SNP CHR BP A1 A2 Z N]


###############################################################################################

cd /exports/eddie/scratch/s2583611/hess-outputs

for f in hess*txt; do

for chrom in {1..22}; do

  python /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/hess/hess.py \
  	--local-hsqg $f \
    --min-maf 0.01 \
   --chrom $chrom \
  	--partition /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/hess/genome-partition/EUR/fourier_ls-chr$chrom.bed \
 	 --bfile /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/1kg_eur_1pct/1kg_eur_1pct_chr$chrom \
 	 --out step1.$f;
     
done
  
    python /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/hess/hess.py \
     --prefix step1.$f \
     --out step2.$f;

done