library(rtracklayer)
gtf <- import("docker/Homo_sapiens.GRCh38.108.chr.gtf.gz")
on_chr22 <- seqnames(gtf) == "22"

export(gtf[on_chr22,], con = "docker/Homo_sapiens.GRCh38.108.chr22.gtf")

chr22_trans <- gtf$transcript_id[which(on_chr22)]

fa <- Biostrings::readDNAStringSet("docker/Homo_sapiens.GRCh38.cdna.all.fa.gz")
names(fa) <- strtrim(names(fa),15)
Biostrings::writeXStringSet(fa[which(names(fa) %in% chr22_trans)],"docker/Homo_sapiens.GRCh38.cdna.chr22.fa")

                            