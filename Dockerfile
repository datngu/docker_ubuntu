FROM ubuntu:22.04

LABEL maintainer="Dat T Nguyen <ndat@utexas.edu"


RUN apt-get update && apt-get install -y \
    make \
    gcc \
    wget \
    git \
    tar \
    libz-dev \
    liblapack-dev \
    libgsl-dev \
    tabix \
    build-essential \
    samtools \
    bedtools \
    bcftools \
    bwa 


RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH
RUN conda config --append channels conda-forge
RUN conda config --append channels bioconda
RUN conda install mamba pip -n base -c conda-forge -y


## install commom python packages
RUN pip install numpy pandas pysam scikit-learn

## install GLIMSE
RUN mkdir /biotools
RUN wget https://github.com/odelaneau/GLIMPSE/releases/download/v2.0.0/GLIMPSE2_chunk_static -O /biotools
RUN wget https://github.com/odelaneau/GLIMPSE/releases/download/v2.0.0/GLIMPSE2_ligate_static -O /biotools
RUN wget https://github.com/odelaneau/GLIMPSE/releases/download/v2.0.0/GLIMPSE2_phase_static -O /biotools
RUN wget https://github.com/odelaneau/GLIMPSE/releases/download/v2.0.0/GLIMPSE2_split_reference_static-O /biotools
RUN wget https://github.com/odelaneau/GLIMPSE/releases/download/v2.0.0/GLIMPSE2_concordance_static -O /biotools

ENV PATH /biotools:$PATH


# RUN mamba install -n base numpy==1.23.2 pandas==2.0.1 pysam samtools bedtools pip -y

