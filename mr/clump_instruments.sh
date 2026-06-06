#!/bin/bash

# PLINK clumping for MR instrument selection
# r2 < 0.01 within 1 Mb, P < 0.05

chr=$1
qtl=$2

mkdir -p results/mr/${qtl}/chr${chr}/clump0.01.p0.05

plink \
--bfile input/genotype_bfile/genotype.chr${chr} \
--clump input/mr/${qtl}/chr${chr}/${qtl}.mr.dataset \
--clump-kb 1000 \
--clump-r2 0.01 \
--clump-snp-field SNP \
--clump-p1 0.05 \
--clump-p2 1 \
--clump-field p \
--out results/mr/${qtl}/chr${chr}/clump0.01.p0.05/${qtl}

awk 'NR>1{print $3}' \
results/mr/${qtl}/chr${chr}/clump0.01.p0.05/${qtl}.clumped \
> results/mr/${qtl}/chr${chr}/clump0.01.p0.05/${qtl}.proxy.snp