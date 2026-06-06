#!/bin/bash

# QTLtools v1.3.1
# Total mQTL permutation mapping
# cis window: ±500 kb

parallel -j 11 \
QTLtools cis \
--vcf input/genotype/genotype.chr{}.vcf.gz \
--bed input/total_mcg/phenotype.chr{}.bed.gz \
--out results/total_mqtl/permutation/mqtl.permute.chr{} \
--window 500000 \
--std-err \
--permute 1000 \
::: {1..22}