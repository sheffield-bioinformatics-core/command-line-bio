FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
MAINTAINER Mark Dunning<m.j.dunning@sheffield.ac.uk>
RUN apt-get update 
RUN apt-get install --fix-missing -y git wget unzip curl r-base
WORKDIR /tmp
RUN wget --no-check-certificate http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip -P /tmp
RUN unzip fastqc_v0.11.3.zip
RUN chmod 755 FastQC/fastqc
RUN ln -s $(pwd)/FastQC/fastqc /usr/bin/fastqc
RUN apt-get install -y samtools default-jre build-essential python python-pip zlib1g-dev


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
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip
RUN unzip Trimmomatic-0.36.zip
ENV TRIMMOMATIC /tmp/Trimmomatic-0.36/trimmomatic-0.36.jar


RUN wget https://github.com/pachterlab/kallisto/releases/download/v0.45.0/kallisto_linux-v0.45.0.tar.gz
RUN tar zxvf kallisto_linux-v0.45.0.tar.gz
RUN ln -s /tmp/kallisto_linux-v0.45.0/kallisto /usr/bin/

RUN wget https://github.com/deweylab/RSEM/archive/v1.3.1.tar.gz
RUN tar zxvf v1.3.1.tar.gz
WORKDIR RSEM-1.3.1 
RUN make
RUN make install 

WORKDIR /tmp
RUN wget https://github.com/COMBINE-lab/salmon/releases/download/v1.2.1/salmon-1.2.1_linux_x86_64.tar.gz
RUN ls
RUN tar xvzf salmon-1.2.1_linux_x86_64.tar.gz

RUN chmod +x /tmp/salmon-latest_linux_x86_64/bin/salmon
RUN ln -s /tmp/salmon-latest_linux_x86_64/bin/salmon /usr/bin


RUN curl -s https://get.nextflow.io | bash
RUN ln -s /tmp/nextflow /usr/bin

## Tidy up to remove temporary files etc

RUN rm /tmp/*.zip
RUN rm /tmp/*.tar.gz


RUN useradd dcuser -m -d /home/dcuser -G sudo -s /bin/bash
RUN chown dcuser /home/dcuser

USER dcuser
RUN mkdir -p /home/dcuser/rnaseq_data


COPY downsampled_fastq.zip /home/dcuser/rnaseq_data
COPY nf_samplesheet.csv /home/dcuser/rnaseq_data
WORKDIR /home/dcuser/rnaseq_data

RUN unzip downsampled_fastq.zip
RUN rm downsampled_fastq.zip

USER root
RUN apt-get install -y man nano
## Attempt to make sure we enter the environment signed-in as 'dcuser'
RUN echo "su - dcuser >> /etc/.basrc"
RUN echo "cd /home/dcuser >> /etc/.bashrc"

ENV DISPLAY=:1.0
