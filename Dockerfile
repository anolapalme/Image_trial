FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV LANG C.UTF-8
RUN export DEBIAN_FRONTEND="noninteractive"

RUN apt-get update 
RUN apt-get install -y apt-utils 
RUN apt-get install -y build-essential 
RUN apt-get install -y checkinstall 
RUN apt-get install -y libreadline-gplv2-dev
RUN apt-get install -y libncursesw5-dev 
RUN apt-get install -y libssl-dev
RUN apt-get install -y libsqlite3-dev 
RUN apt-get install -y tk-dev
RUN apt-get install -y libgdbm-dev 
RUN apt-get install -y libc6-dev 
RUN apt-get install -y libbz2-dev 
RUN apt-get install -y wget 
RUN apt-get install -y curl

RUN apt-get update && apt-get -y upgrade 
RUN apt-get install -y apt-utils 
RUN apt-get install -y build-essential && \ 
     apt-get install -y python && apt-get update 
RUN  apt-get install -y python-pip && pip install --upgrade pip && apt-get update && apt-get install -y wget && \ 
     rm -rf /var/lib/apt/lists/* && apt-get update && apt-get install -y git && apt-get install -y python-qt4 
     
RUN  gcc --version

#install miniconda
# Now install Anaconda to manage the python environment. This installs numpy, scipy, matplotlib,
# jupyter etc. Type conda list inside the built docker container, to view the python modules already
# installed.
RUN wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh
RUN bash Anaconda2-4.2.0-Linux-x86_64.sh -b -p /home/soft/anaconda
RUN rm Anaconda2-4.2.0-Linux-x86_64.sh
ENV PATH /home/soft/anaconda/bin:$PATH

RUN conda config --add channels defaults
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda config --add channels etetoolkit
RUN conda config --add channels biocore

#install cmake
RUN apt-get update && apt-get install -y cmake && export CC=clang && export CXX=clang++

RUN apt-get update && apt-get install -y python2.7 python-pip  build-essential

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

#RUN conda install -c bioconda hisat2

#install ncbi-blast+
#RUN apt-get update
#RUN apt-get install -y ncbi-blast+

#install samtools
#RUN apt-get install -y samtools

#install rmblast
#RUN conda install -y rmblast

#install tbl2asn
#RUN conda install -y tbl2asn

#install pslcdnafilet
#RUN conda install -y ucsc-pslcdnafilter

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

#install eggnog
RUN conda install -c bioconda eggnog-mapper 

#install blat
RUN conda install -c bioconda blat 
RUN conda install -c bioconda repeatmasker 

RUN conda install -c bioconda hisat2 
RUN conda install -c bioconda fasta3 
RUN conda install -c biobuilds fasta

RUN conda install -c etetoolkit ete3 ete_toolchain && ete3 build check && export PATH=~/anaconda_ete/bin:$PATH

RUN conda install -c bioconda ucsc-pslcdnafilter 

RUN cd /  &&  wget www.repeatmasker.org/utils/rmOutToGFF3.pl 
ENV PATH=~/rmOutToGFF3.pl:$PATH


#RUN cd / && wget http://topaz.gatech.edu/GeneMark/tmp/GMtool_Sw4B9/gm_et_linux_64.tar.gz 
#RUN ls -l 
#RUN tar -xvf gm_et_linux_64.tar.gz 
#RUN cp gm_et_linux_64/gmes_petap/gm_key ~/.gm_key && ls -l ~ 
#RUN cp gm_et_linux_64/gmes_petap/gmes_petap.pl /
#RUN PATH=/gmes_petap.pl:$PATH
#ENV PATH=/gm_et_linux_64/gmes_petap/:$PATH
#ENV GENEMARK_PATH=/gm_et_linux_64/gmes_petap/gmes_petap.pl
#RUN echo $GENEMARK_PATH 

RUN conda install -c biobuilds fasta 

RUN wget http://faculty.virginia.edu/wrpearson/fasta/fasta36/fasta-36.3.8e.tar.gz && \
    tar -zxvf fasta-36.3.8e.tar.gz && rm fasta-36.3.8e.tar.gz && \
    cd fasta-36.3.8e/src && make -f ../make/Makefile.linux fasta36 

RUN conda install -y -c bioconda raxml infernal fisher hmmer infernal 
#RUN cp /rmOutToGFF3.pl /home/soft/anaconda/share/RepeatMasker/ && ls -lt && ls /bin/ 
#RUN cp /gmes_petap.pl  /home/soft/anaconda/share/RepeatMasker/
#RUN export PATH=/gmes_petap.pl:$PATH
RUN export PATH=/bin/rmOutToGFF3.pl:$PATH && PATH=/rmOutToGFF3.pl:$PATH && echo $PATH 
RUN ls /fasta-36.3.8e/bin/fasta36
ENV PATH=/fasta-36.3.8e/bin/fasta36:$PATH
ENV PATH=/conda/bin/fasta36:$PATH
RUN ls /fasta-36.3.8e/bin/fasta36 && echo $PATH
ENV BAMTOOLS_PATH=/conda/bin/bamtools/bin
ENV TRINITYHOME=/conda/bin/trinity/bin 
ENV AUGUSTUS_CONFIG_PATH=/conda/bin/augustus/bin
RUN apt-get install build-essential build-essential
RUN conda install -c bioconda pasa 
ENV PASAHOME=/conda/bin/pasa/bin
RUN git clone https://github.com/EVidenceModeler/EVidenceModeler.git 
ENV EVM_HOME=/EVidenceModeler

RUN conda update -y conda && conda install perl-app-cpanminus
RUN cpanm Bio::Perl Clone DBD::mysql File::Which Hash::Merge JSON LWP Logger::Simple Text::Soundex YAML 
ENV export PATH=~/rmOutToGFF3.pl:$PATH

RUN wget https://github.com/nextgenusfs/funannotate/archive/1.3.4.tar.gz && tar -zxvf 1.3.4.tar.gz && rm 1.3.4.tar.gz && mv funannotate-1.3.4 funannotate && cd funannotate && export PATH=$PWD:$PATH && funannotate check
