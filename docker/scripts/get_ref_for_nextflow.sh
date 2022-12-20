### Script for building the references we need for nextflow - in case we didn't run the exercises

cd /data

wget https://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_rm.chromosome.22.fa.gz -P ref_data
gunzip ref_data/Homo_sapiens.GRCh38.dna_rm.chromosome.22.fa.gz

salmon index -i index/GRCh38_salmon -t ref_data/Homo_sapiens.GRCh38.cdna.chr22.fa