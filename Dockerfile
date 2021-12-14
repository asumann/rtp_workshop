FROM nfcore/base:1.14
LABEL authors="Barry Digby" \
      description="Docker container containing fastqc"

RUN apt-get update; apt-get clean all; apt-get install --yes unzip

WORKDIR ./
COPY environment.yml ./
RUN conda env create -f environment.yml && conda clean -a
ENV PATH /opt/conda/envs/test_env/bin:$PATH

RUN mkdir -p /usr/src/scratch
WORKDIR /usr/src/scratch
RUN wget https://github.com/BenLangmead/bowtie2/releases/download/v2.4.4/bowtie2-2.4.4-linux-x86_64.zip
RUN unzip bowtie2-2.4.4-linux-x86_64.zip
ENV PATH=/usr/src/scratch/bowtie2-2.4.4-linux-x86_64/:$PATH

RUN apt-get install --yes build-essential \
                        gcc-multilib \
                        tar \
                        unzip \
                        ncurses-base \
                        zlib1g \
                        liblzma5 \
                        libbz2-1.0 \
                        gcc \
                        g++ \
                        zlib1g-dev