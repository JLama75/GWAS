#!/bin/bash

Trait="Your_Study_Name"
echo Trait: $Trait

for j in 'GO_BP' 'GO_CC' 'GO_MF' 'HALLMARK' 'KEGG' 'MGI' 'REACTOME'; do
  sbatch sc_magma_GeneSet.step2.sh $Trait $j
done

