nextflow run nf-core/rnaseq -profile singularity \
--skip_alignment \
--skip_trimming \
--pseudo_aligner salmon \
--input nf_samplesheet.csv \
--fasta ref_data/Homo_sapiens.GRCh38.dna_rm.chromosome.22.fa \
--transcript_fasta ref_data/Homo_sapiens.GRCh38.cdna.chr22.fa \
--gtf ref_data/Homo_sapiens.GRCh38.108.chr22.gtf \
--salmon_index index/GRCh38_salmon \
--outdir nf_results 