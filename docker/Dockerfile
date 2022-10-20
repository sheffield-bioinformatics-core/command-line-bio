FROM consol/ubuntu-xfce-vnc
MAINTAINER Mark Dunning<m.j.dunning@sheffield.ac.uk>
USER 0
RUN apt-get update 
RUN apt-get install --fix-missing -y git wget unzip curl r-base samtools default-jre build-essential zlib1g-dev
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

#RUN curl -s "https://get.sdkman.io" | bash
#RUN chmod +x /headless/.sdkman/bin/sdkman-init.sh
#RUN /headless/.sdkman/bin/sdkman-init.sh
#RUN sdk install java

RUN apt-get update && apt-get install -y software-properties-common sudo && \
    add-apt-repository -y ppa:linuxuprising/java && \
    apt-get update && \
    echo oracle-java17-installer shared/accepted-oracle-license-v1-3 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java17-installer && \
    apt install oracle-java17-set-default
RUN curl -s https://get.nextflow.io | bash
RUN ln -s /tmp/nextflow /usr/bin


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

##docker run --rm -d -p 5901:5901 -p 6901:6901 --privileged sheffieldbioinformatics/unixtraining

## http://localhost:6901/?password=vncpassword