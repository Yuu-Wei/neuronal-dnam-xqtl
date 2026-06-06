#!/bin/bash

# QTLtools v1.3.1
# eQTL nominal mapping
# QTLtools default cis window (±1 Mb)

parallel -j 11 \
QTLtools cis \
--vcf input/genotype/genotype.chr{}.vcf.gz \
--bed input/expression/phenotype.chr{}.bed.gz \
--out results/eqtl/nominal/eqtl.nominal.chr{} \
--std-err \
--nominal 1 \
::: {1..22}