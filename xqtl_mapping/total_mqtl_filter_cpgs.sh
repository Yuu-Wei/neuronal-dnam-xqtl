#!/bin/bash

# QTLtools v1.3.1
# Total mQTL CpG filtering
# cis window: ±500 kb
# CpG sites were first selected based on Total mQTL
# nominal associations (P < 1e-6) to reduce the
# number of CpG sites included in subsequent
# nominal mQTL analyses.

chr=$1

QTLtools cis \
--vcf input/genotype/genotype.chr${chr}.vcf.gz \
--bed input/total_mcg/phenotype.chr${chr}.bed.gz \
--out results/total_mqtl/filtering/mqtl.nominal.p1e-6.chr${chr} \
--window 500000 \
--std-err \
--nominal 1e-6

awk '{print $1}' \
results/total_mqtl/filtering/mqtl.nominal.p1e-6.chr${chr} \
| sort -u \
> results/total_mqtl/filtering/chr${chr}.nominal.p1e-6.cpgid

rm results/total_mqtl/filtering/mqtl.nominal.p1e-6.chr${chr}