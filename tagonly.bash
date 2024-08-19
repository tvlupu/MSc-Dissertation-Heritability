#!/bin/sh

#$ -N tagging            
#$ -cwd                  
#$ -l h_rt=02:00:00 
#$ -l h_vmem=15G

#$ -l rl9=true

. /etc/profile.d/modules.sh

cd /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ldak/


# option for SumHer
for j in {1..22}; do
./ldak5.2.linux --calc-tagging HumDef$j --bfile /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ref --power -0.25 --chr $j
done

rm list.txt; for j in {1..22}; do echo "HumDef$j.tagging" >> list.txt; done
./ldak5.2.linux --join-tagging HumDef --taglist list.txt


# option for SumHer-LDSC
#for j in {1..22}; do
#./ldak5.2.linux --calc-tagging HumDef-ldsc$j --bfile /gpfs/igmmfs01/eddie/GWAS-annotations/tvl-msc/ref --power -1 --chr $j
#done

#rm list.txt; for j in {1..22}; do echo "HumDef-ldsc$j.tagging" >> list.txt; done
#./ldak5.2.linux --join-tagging HumDef-ldsc --taglist list.txt