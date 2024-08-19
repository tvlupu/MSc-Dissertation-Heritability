#LDSC file:
#[SNP     A1      A2      N       Z]

#summary file:
#[CHR     SNP     BP      A1      A2      N       AF1     BETA    SE      P]

######################################

## prepping HESS files ## 

cd /exports/eddie/scratch/s2583611/

mkdir hess-prep
cd /exports/eddie/scratch/s2583611/hess-prep

cp /exports/eddie/scratch/s2583611/ldsc-outputs/cleaned*.txt /exports/eddie/scratch/s2583611/hess-prep    # LDSC files of the form cleaned.snps10N.5.fastGWA.txt
for f in cleaned*.fastGWA.gz.txt; do sort -k1 $f > sorted.$f; done # sort LDSC file by SNP

cp /exports/eddie/scratch/s2583611/cleaned-sumstats/cleaned* /exports/eddie/scratch/s2583611/hess-prep    # summary files of the form cleaned.snps10N.5.txt
for f in cleaned*.txt; do sort -k2 $f > sorted.$f; done # sort summary file by SNP

for f in sorted*.fastGWA.gz.txt; # for each file pair (LDSC + summary)
do join -1 1 -2 2 "$f" "${f/.fastGWA.gz.txt/}" \ 
-o 1.1,2.1,2.3,1.2,1.3,1.4,1.5 > hess.$f; # choose approproate cols from each sorted file after joining by SNP ID
done

#output file has columns:
#[SNP    CHR    BP    A1    A2    Z    N]

rm sorted*

for f in hess*; do mv "$f" "${f//sorted.cleaned./}"; done   
for f in hess*; do mv "$f" "${f//.fastGWA.gz/}"; done       # rename output file (remove extra tags)