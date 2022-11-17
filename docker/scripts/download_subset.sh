wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732904/ERR732904.fastq.gz -O ERR732904.fastq.gz
zcat ERR732904.fastq.gz | head -n 52000 > ERR732904_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732909/ERR732909.fastq.gz -O ERR732909.fastq.gz
zcat ERR732909.fastq.gz | head -n 56000 > ERR732909_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732908/ERR732908.fastq.gz -O ERR732908.fastq.gz
zcat ERR732908.fastq.gz | head -n 58000 > ERR732908_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732906/ERR732906.fastq.gz -O ERR732906.fastq.gz
zcat ERR732906.fastq.gz | head -n 54000 > ERR732906_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732901/ERR732901.fastq.gz -O ERR732901.fastq.gz
zcat ERR732901.fastq.gz | head -n 62000 > ERR732901_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732903/ERR732903.fastq.gz -O ERR732903.fastq.gz
zcat ERR732903.fastq.gz | head -n 64000 > ERR732903_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732902/ERR732902.fastq.gz -O ERR732902.fastq.gz
zcat ERR732902.fastq.gz | head -n 52060 > ERR732902_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732905/ERR732905.fastq.gz -O ERR732905.fastq.gz
zcat ERR732905.fastq.gz | head -n 52020 > ERR732905_sub.fastq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR732/ERR732907/ERR732907.fastq.gz -O ERR732907.fastq.gz
zcat ERR732907.fastq.gz | head -n 52040 > ERR732907_sub.fastq

