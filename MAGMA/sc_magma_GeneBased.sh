#!/bin/bash
#SBATCH --job-name=magma    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL) 
#SBATCH --mem=10G --nodes=1          # Job memory request
#SBATCH --output=Step1_magma_%j.log   # Standard output and error log
#SBATCH --partition=long

#GWAS summary statistic- CHROM	POS	ID	OBS_CT	P   #With column names
#GWAS SNP location file - ID CHROM POS   #No column names

SNP_loc="GWAS_SNP_Location"
GWAS_sumstat= "Your_GWAS_summary_statistic"
GeneAnnotation="/data/Segre_Lab/data/MAGMA/NCBI38/NCBI38.gene.loc"
Trait="YourStudyName"

bfile_EUR="/data/Segre_Lab/data/1000Genomes/NYGC_HG38/1kg_EUR_chr_b38"
bfile_ALL="/data/Segre_Lab/data/1000Genomes/NYGC_HG38/1kg_All_chr_b38"

#Code:

#step1: Annotation: maps SNPs to genes
magma --annotate window=100 --snp-loc ${SNP_loc} --gene-loc ${GeneAnnotation} --out 'qt.'${Trait}'_annot'

#step2: Compute association of study with phenotype
if [[ $snpLoc == *"EUR"* ]]; then
  magma --bfile ${bfile_ALL} --pval ${GWAS_sumstat} use=3,5 ncol='OBS_CT' --gene-annot 'qt.'${Trait}'_annot.genes.annot' --gene-model snp-wise=top --out 'GENE_qt.'${Trait}
else
  magma --bfile ${bfile_EUR} --pval ${GWAS_sumstat} use=3,5 ncol='OBS_CT' --gene-annot 'qt.'${Trait}'_annot.genes.annot' --gene-model snp-wise=top --out 'GENE_qt.'${Trait}
fi


