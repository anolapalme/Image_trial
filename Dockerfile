FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV LANG C.UTF-8
RUN export DEBIAN_FRONTEND="noninteractive"

RUN  apt-get update && apt-get install -y build-essential && apt-get install -y checkinstall && apt-get install -y libreadline-gplv2-dev && apt-get install -y libncursesw5-dev &&  apt-get install -y libssl-dev && apt-get install -y libsqlite3-dev && apt-get install -y tk-dev && apt-get install -y libgdbm-dev && apt-get install -y libc6-dev && apt-get install -y libbz2-dev && apt-get install -y wget && apt-get install -y curl

#install miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda
RUN conda config --add channels defaults
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda config --add channels etetoolkit
RUN conda config --add channels biocore

#install cmake
RUN apt-get update
RUN apt-get install -y cmake
RUN export CC=clang
RUN export CXX=clang++

RUN apt-get update
RUN apt-get install -y python2.7 python-pip

RUN python2.7 -V
RUN pip install --upgrade pip
RUN pip install msgpack-python
RUN pip install lxml
RUN pip install six
RUN pip install Cython
RUN pip install natsort
RUN pip install biopython
RUN pip install goatools
RUN pip install matplotlib
RUN pip install natsort
RUN pip install numpy
RUN pip install pandas
RUN pip install psutil
RUN pip install scikit-learn
RUN pip install scipy
RUN pip install seaborn

 #install cpanm and Perl
RUN apt-get -qy update
RUN apt-get -qy --force-yes upgrade
RUN apt-get -qy --force-yes dist-upgrade
RUN apt-get install -qy --force-yes perl build-essential cpanminus
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#install the perl modules
RUN cpanm Bio::Perl
RUN cpanm Carp
RUN cpanm Clone
RUN cpanm DBI
RUN cpanm Data::Dumper
RUN cpanm File::Basename
RUN cpanm Getopt::Long
RUN cpanm Hash::Merge
RUN cpanm Logger::Simple
RUN cpanm POSIX
RUN cpanm Parallel::ForkManager
RUN cpanm Pod::Usage
RUN cpanm Scalar::Util::Numeric
RUN cpanm Storable
RUN cpanm Text::Soundex
RUN cpanm Thread::Queue
RUN cpanm Tie::File
RUN cpanm YAML
RUN cpanm threads
RUN cpanm threads::shared
RUN cpanm JSON
RUN cpanm LWP::UserAgent
RUN cpanm File::Which
RUN cpanm DBD::SQLite

RUN conda install -c etetoolkit ete3 ete_toolchain && ete3 build check && export PATH=~/anaconda_ete/bin:$PATH
RUN conda install -c bioconda hisat2

#install ncbi-blast+
RUN apt-get update
RUN apt-get install -y ncbi-blast+

#install samtools
RUN apt-get install -y samtools

#install rmblast
RUN conda install -y rmblast

#install tbl2asn
RUN conda install -y tbl2asn

#install pslcdnafilet
RUN conda install -y ucsc-pslcdnafilter

#install Mummer
RUN conda install -c bioconda mummer

#install kallisto
RUN conda install -c bioconda kallisto

#install gamp
RUN conda install -c jrderuiter gmap

#install Trinity
RUN conda install -c bioconda trinity

#install RepeatModeller
RUN conda install -c bioconda repeatmodeler

#install Diamond
RUN conda install -c bioconda diamond

#install exonerate
RUN conda install -c bioconda exonerate

#install braker
RUN conda install -c bioconda braker

#install bedtools
RUN conda install -c bioconda bedtools

#install bamtools
RUN conda install -c bioconda bamtools

#install makeblastdb
#RUN wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz  && tar -xvzf RepeatMasker-open-4-0-7.tar.gz 
#RUN cd RepeatMasker-open-4-0-7 
#RUN ls
#install augustus
RUN conda install -c bioconda augustus 

#install trimal
RUN conda install -c bioconda trimal 

#install trnascan-se 
RUN conda install -c bioconda trnascan-se 

#install minimap2
RUN conda install -c bioconda minimap2 

#install mafft
RUN wget https://mafft.cbrc.jp/alignment/software/mafft-7.402-without-extensions-src.tgz && tar -zxvf mafft-7.402-without-extensions-src.tgz && cd mafft-7.402-without-extensions/core/  && make clean && make && make install && export PATH=$PAWD:$PATH && cd

#install git 
RUN apt-get update && apt-get upgrade && apt-get install -y git

#install fasta3
RUN git clone https://github.com/wrpearson/fasta36.git 
RUN ls


#install eggnog
RUN conda install -c bioconda eggnog-mapper 

#install blat
RUN conda install -c bioconda blat 

RUN conda install -c biobuilds fasta  

RUN conda install -c bioconda repeatmasker 


RUN wget https://github.com/nextgenusfs/funannotate/archive/1.3.4.tar.gz && tar -zxvf 1.3.4.tar.gz && rm 1.3.4.tar.gz && mv funannotate-1.3.4 funannotate && cd funannotate && export PATH=$PWD:$PATH && echo $PATH &&  funannotate check
