#!/bin/bash
#SBATCH --job-name=magma    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)  
#SBATCH --mem=10G --nodes=1          # Job memory request
#SBATCH --output=Step2_magma_%j.log   # Standard output and error log
#SBATCH --partition=medium,long

module load MAGMA/1.10

#Step3: Gene set analysis: test gene association in gene set

snpLoc=$1 #"Your_Study_Name"
j=$2 # Gene_Set eg-HALLMARK

step1_results='GENE_qt.'$snpLoc'.genes.raw'
Gene_set_annotation='/data/Segre_Lab/data/Gene_Set_Resources/MAGMA_Formatted_09302022/MAGMA_'

#Code
echo filename: $snpLoc geneset: $j
magma --gene-results "${step1_results}" --set-annot "${Gene_set_annotation}$j_Genesets_09302022.tsv" --model correct=all --out 'GENE_'$snpLoc'_'$j'_GSEA'
#output= GENE_FAME.EUR_GSEA.gsa.sets.genes.out

