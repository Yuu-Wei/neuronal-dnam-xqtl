#!/bin/bash

# QTLtools v1.3.1
# eQTL permutation mapping
# QTLtools default cis window (±1 Mb)

parallel -j 11 \
QTLtools cis \
--vcf input/genotype/genotype.chr{}.vcf.gz \
--bed input/expression/phenotype.chr{}.bed.gz \
--out results/eqtl/permute/eqtl.permute.chr{} \
--std-err \
--permute 1000 \
::: {1..22}