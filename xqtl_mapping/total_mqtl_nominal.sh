#!/bin/bash

# QTLtools v1.3.1
# Total mQTL nominal mapping
# cis window: ±500 kb
# The same set of CpG sites selected from Total mQTL
# filtering was also used for True mQTL and hmQTL analyses.

parallel -j 11 \
QTLtools cis \
--vcf input/genotype/genotype.chr{}.vcf.gz \
--bed input/total_mcg/phenotype.chr{}.bed.gz \
--out results/total_mqtl/nominal/mqtl.nominal.chr{} \
--window 500000 \
--std-err \
--nominal 1 \
::: {1..22}