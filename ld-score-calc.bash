#!/bin/sh
# Grid Engine options (lines prefixed with #$)
#$ -N ld-score-calc              
#$ -cwd                  
#$ -l h_rt=32:00:00 
#$ -l h_vmem=15G
#$ -l rl9=true

. /etc/profile.d/modules.sh

module load anaconda
conda activate ldsc



# estimating univariate LD scores for the 1000 genomes reference set

python ldsc.py --bfile /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ref --l2 --ld-wind-cm 1 --maf 0.01 --out ref
# defines window to 1cM and sets MAF>0.01 (default)