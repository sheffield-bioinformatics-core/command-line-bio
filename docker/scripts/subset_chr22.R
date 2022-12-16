library(rtracklayer)

if(!file.exists("Homo_sapiens.GRCh38.108.chr.gtf.gz")) download.file("https://ftp.ensembl.org/pub/release-108/gtf/homo_sapiens/Homo_sapiens.GRCh38.108.chr.gtf.gz",
                                                                     destfile = "Homo_sapiens.GRCh38.108.chr.gtf.gz")

gtf <- import("Homo_sapiens.GRCh38.108.chr.gtf.gz")
on_chr22 <- seqnames(gtf) == "22"

export(gtf[on_chr22,], con = "../Homo_sapiens.GRCh38.108.chr22.gtf")

chr22_trans <- gtf$transcript_id[which(on_chr22)]

if(!file.exists("Homo_sapiens.GRCh38.cdna.all.fa.gz")) download.file("https://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz",
                                                                     destfile ="Homo_sapiens.GRCh38.cdna.all.fa.gz" )
fa <- Biostrings::readDNAStringSet("Homo_sapiens.GRCh38.cdna.all.fa.gz")
names(fa) <- strtrim(names(fa),15)
Biostrings::writeXStringSet(fa[which(names(fa) %in% chr22_trans)],"../Homo_sapiens.GRCh38.cdna.chr22.fa")

                            