FROM consol/ubuntu-xfce-vnc
MAINTAINER Mark Dunning<m.j.dunning@sheffield.ac.uk>
USER 0
RUN apt-get update 
RUN apt-get install --fix-missing -y git wget unzip curl samtools default-jre build-essential zlib1g-dev bwa nano dos2unix
WORKDIR /tmp
RUN wget --no-check-certificate http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip -P /tmp
RUN unzip fastqc_v0.11.3.zip
RUN chmod 755 FastQC/fastqc
RUN ln -s $(pwd)/FastQC/fastqc /usr/bin/fastqc

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
     /bin/bash ./miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
RUN conda install multiqc

WORKDIR /tmp
RUN wget https://github.com/COMBINE-lab/salmon/releases/download/v1.2.1/salmon-1.2.1_linux_x86_64.tar.gz
RUN ls
RUN tar xvzf salmon-1.2.1_linux_x86_64.tar.gz

RUN chmod +x /tmp/salmon-latest_linux_x86_64/bin/salmon
RUN ln -s /tmp/salmon-latest_linux_x86_64/bin/salmon /usr/bin




## install nextflow

RUN apt-get update && apt-get install -y software-properties-common sudo && \
    add-apt-repository -y ppa:linuxuprising/java && \
    apt-get update && \
    echo oracle-java17-installer shared/accepted-oracle-license-v1-3 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java17-installer && \
    apt install oracle-java17-set-default


## install singularity

RUN apt-get update && sudo apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git \
    cryptsetup \
    glib2.0-dev

RUN wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz  # Downloads the required Go package
RUN tar -C /usr/local -xzvf go1.19.2.linux-amd64.tar.gz   # Extracts the archive
ENV PATH=/usr/local/go/bin:$PATH
RUN wget https://github.com/sylabs/singularity/releases/download/v3.10.3/singularity-ce-3.10.3.tar.gz
RUN tar -xzf singularity-ce-3.10.3.tar.gz
WORKDIR singularity-ce-3.10.3
RUN ./mconfig && \
  make -C builddir && \
  make -C builddir install
  
WORKDIR /home

## Download nf.core cache images to make workflow quicker

WORKDIR /tmp
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
RUN curl -fsSL https://ewels.github.io/AWS-iGenomes/aws-igenomes.sh > /usr/bin/aws-igenomes.sh
RUN chmod +x /usr/bin/aws-igenomes.sh



RUN useradd dcuser -m -d /home/dcuser -G sudo -s /bin/bash
RUN chown dcuser /home/dcuser


USER dcuser
RUN mkdir -p /home/dcuser/shell_data
RUN mkdir -p /home/dcuser/rnaseq_data

COPY dc_sample_data.zip /home/dcuser/shell_data
WORKDIR /home/dcuser/shell_data
RUN unzip dc_sample_data.zip
RUN rm dc_sample_data.zip

WORKDIR /home/dcuser/rnaseq_data/


RUN mkdir /home/dcuser/rnaseq_data/scripts
RUN mkdir /home/dcuser/rnaseq_data/fastq
RUN mkdir /home/dcuser/rnaseq_data/ref_data
COPY nf_samplesheet.csv /home/dcuser/rnaseq_data/
COPY fastq/*_sub.fastq.gz /home/dcuser/rnaseq_data//fastq/
COPY scripts/* /home/dcuser/rnaseq_data/scripts/
RUN dos2unix -n scripts/get_ref_for_nextflow.sh scripts/get_ref_for_nextflow2.sh
RUN mv scripts/get_ref_for_nextflow2.sh scripts/get_ref_for_nextflow.sh
RUN dos2unix -n scripts/run_nextflow.sh scripts/run_nextflow2.sh
RUN mv scripts/run_nextflow2.sh scripts/run_nextflow.sh
COPY Homo_sapiens.GRCh38.cdna.chr22.fa /home/dcuser/rnaseq_data/ref_data
COPY Homo_sapiens.GRCh38.108.chr22.gtf  /home/dcuser/rnaseq_data/ref_data

#RUN wget https://ndownloader.figshare.com/articles/3219673?private_link=f5d63d8c265a05618137 -O fastq.zip

#RUN unzip fastq.zip -d /home/dcuser/rnaseq_data/
#RUN rm fastq.zip
#RUN rm /home/dcuser/rnaseq_data/chr1*

#RUN rm /home/dcuser/rnaseq_data/targets2.txt

WORKDIR /home/dcuser/rnaseq_data
RUN curl -s https://get.nextflow.io | bash
RUN chmod +x /home/dcuser/rnaseq_data/nextflow

RUN mkdir /home/dcuser/rnaseq_data/singularity-cache
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-fastqc-0.11.9--0.img https://depot.galaxyproject.org/singularity/fastqc:0.11.9--0
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-bioconductor-summarizedexperiment-1.20.0--r40_0.img https://depot.galaxyproject.org/singularity/bioconductor-summarizedexperiment:1.20.0--r40_0
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-bioconductor-tximeta-1.8.0--r40_0.img https://depot.galaxyproject.org/singularity/bioconductor-tximeta:1.8.0--r40_0
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-multiqc-1.11--pyhdfd78af_0.img https://depot.galaxyproject.org/singularity/multiqc:1.11--pyhdfd78af_0
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-perl-5.26.2.img https://depot.galaxyproject.org/singularity/perl:5.26.2
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-python-3.9--1.img https://depot.galaxyproject.org/singularity/python:3.9--1
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-salmon-1.5.2--h84f40af_0.img https://depot.galaxyproject.org/singularity/salmon:1.5.2--h84f40af_0
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-samtools-1.15.1--h1170115_0.img https://depot.galaxyproject.org/singularity/samtools:1.15.1--h1170115_0
RUN singularity pull singularity-cache/depot.galaxyproject.org-singularity-ubuntu-20.04.img https://depot.galaxyproject.org/singularity/ubuntu:20.04
#RUN singularity pull singularity-cache/singularity-cache/depot.galaxyproject.org-singularity-mulled-v2-8849acf39a43cdd6c839a369a74c0adc823e2f91-ab110436faf952a33575c64dd74615a84011450b-0.img https://depot.galaxyproject.org/singularity/mulled:v2-8849acf39a43cdd6c839a369a74c0adc823e2f91-ab110436faf952a33575c64dd74615a84011450b-0


ENV NXF_SINGULARITY_CACHEDIR=/home/dcuser/rnaseq_data/singularity-cache
WORKDIR /home/dcuser/rnaseq_data
RUN salmon index -i index/GRCh38_salmon -t ref_data/Homo_sapiens.GRCh38.cdna.chr22.fa

WORKDIR /home/dcuser/rnaseq_data/
RUN chmod 777 nf_samplesheet.csv
RUN wget https://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_rm.chromosome.22.fa.gz -P ref_data
RUN gunzip ref_data/Homo_sapiens.GRCh38.dna_rm.chromosome.22.fa.gz

#ENV HOME=/home/dcuser
## build command
##docker build -t="sheffieldbioinformatics/unix-training" .

## run command
##docker run -v --rm -d -p 5901:5901 -p 6901:6901 --privileged sheffieldbioinformatics/unix-training

## http://localhost:6901/?password=vncpassword