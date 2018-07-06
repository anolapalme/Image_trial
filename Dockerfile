FROM ubuntu:17.10

ENV LANG C.UTF-8
ENV TERM linux
ENV export DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get -y upgrade && apt-get install -y apt-utils &&  apt-get install -y build-essential && \ 
     apt-get install -y python && apt-get update &&  \ 
     apt-get install -y python-pip && pip install --upgrade pip && apt-get update && apt-get install -y wget && \ 
     rm -rf /var/lib/apt/lists/* && apt-get update && apt-get install -y git && apt-get install -y python-qt4 
     
RUN  gcc --version

#install miniconda
RUN wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b && \
    rm Miniconda-latest-Linux-x86_64.sh 

ENV PATH=/miniconda/bin:${PATH} 

RUN conda update -y conda && conda config --add channels defaults && \
    conda config --add channels conda-forge && conda config --add channels bioconda && conda config --add channels etetoolkit

#install pip modules 
RUN pip install --upgrade pip && pip install msgpack-python lxml six ete3 Cython natsort biopython goatools matplotlib numpy pandas \
    psutil scikit-learn scipy seaborn

#install external dependancies
RUN apt-get update -y
RUN apt-get upgrade -y

#install cmake
RUN apt-get update
RUN apt-get install -y cmake
RUN export CC=clang
RUN export CXX=clang++

#install modules apt-get
RUN apt-get install -y ncbi-blast+ 
RUN apt-get install -y samtools
RUN conda install -y rmblast 
RUN conda install -y tbl2asn 
RUN conda install -y ucsc-pslcdnafilter 
RUN conda install -c bioconda mummer 
RUN conda install -c bioconda kallisto 
RUN conda install -c jrderuiter gmap 
RUN conda install -c etetoolkit ete3 ete_toolchain && ete3 build check && export PATH=~/anaconda_ete/bin:$PATH
RUN conda install -c bioconda trinity 
RUN conda install -c bioconda repeatmasker 
RUN conda install -c bioconda repeatmodeler 
RUN conda install -c bioconda diamond
RUN conda install -c bioconda exonerate 
RUN conda install -c bioconda braker 
RUN conda install -c bioconda bedtools 
RUN conda install -c bioconda bamtools 
RUN conda install -c bioconda augustus 
RUN conda install -c bioconda eggnog-mapper
RUN conda install -c bioconda blat 
RUN conda install -c bioconda hisat2

#install funannotate
RUN wget https://github.com/nextgenusfs/funannotate/archive/1.0.0.tar.gz
RUN tar -zxvf 1.0.0.tar.gz
RUN rm 1.0.0.tar.gz && pwd
RUN cd funannotate-1.0.0 && cwd=$PWD && PATH=$cwd:$PATH && echo $PATH &&  pwd

#RUN make install
RUN pip install biopython
#install cpanm and Perl
RUN apt-get -qy update
RUN apt-get -qy --force-yes upgrade
RUN apt-get -qy --force-yes dist-upgrade
RUN apt-get install -qy --force-yes perl build-essential cpanminus
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#install the perl modules
RUN cpanm --force Bio::Perl 
RUN cpanm --force Carp 
RUN cpanm --force Clone 
RUN cpanm --force DBI 
RUN cpanm --force Data::Dumper 
RUN cpanm --force File::Basename 
RUN cpanm --force Getopt::Long 
RUN cpanm --force Hash::Merge 
RUN cpanm --force Logger::Simple 
RUN cpanm --force POSIX 
RUN cpanm --force Parallel::ForkManager 
RUN cpanm --force Pod::Usage 
RUN cpanm --force Scalar::Util::Numeric 
RUN cpanm --force Storable 
RUN cpanm --force Text::Soundex 
RUN cpanm --force Thread::Queue 
RUN cpanm --force Tie::File 
RUN cpanm --force YAML 
RUN cpanm --force threads 
RUN cpanm --force threads::shared 
RUN cpanm --force JSON 
RUN cpanm --force DBD::mysql 
RUN cpanm --force LWP::UserAgent
RUN cpanm --force DBD::SQLite 
RUN cpanm --force File::Which

RUN conda install -c bioconda braker 

RUN conda install -c bioconda repeatmasker 

RUN conda install -c biobuilds fasta  
RUN conda install -c bioconda fasta-splitter 
RUN conda install fastx_toolkit


RUN cd /miniconda/share/RepeatMasker/ && pwd  && wget www.repeatmasker.org/utils/rmOutToGFF3.pl && export PATH=$PWD/rmOutToGFF3.pl:$PATH


#RUN wget http://topaz.gatech.edu/GeneMark/tmp/GMtool_QlIES/gm_key_64.gz  
#RUN zcat gm_key_64.gz > .gm_key
RUN wget http://topaz.gatech.edu/GeneMark/tmp/GMtool_SAp2t/gm_et_linux_64.tar.gz 
RUN pwd
RUN tar -xvf gm_et_linux_64.tar.gz 
RUN cp gm_et_linux_64/gmes_petap/gm_key .gm_key && ls -l ~ 
ENV PATH=/gm_et_linux_64/gmes_petap/gmes_petap.pl:$PATH
ENV GENEMARK_PATH=/gm_et_linux_64/gmes_petap/gmes_petap.pl
RUN echo $GENEMARK_PATH 
RUN export PATH=/gm_et_linux_64/gmes_petap/:$PATH
RUN pwd && ls -la
RUN cp /gm_et_linux_64/gmes_petap/gmes_petap.pl .
RUN ls -la

#RUN cp gm_et_linux_64/gmes_petap/gm_key .gm_key 
#RUN ls gm_et_linux_64/gmes_petap/ 
#RUN -la && PATH=gm_et_linux_64/gmes_petap/gmes_petap.pl:$PATH && ls -la
 
# ENV PATH=gm_et_linux_64/gmes_petap/:$PATH
# RUN echo $PATH
# RUN cp gm_et_linux_64/gmes_petap/gmes_petap.pl . && chmod -x gmes_petap.pl
 
# ENV GENEMARK_PATH=/gm_et_linux_64/gmes_petap/gmes_petap.pl
 
# RUN echo $GENEMARK_PATH
# RUN find . -type f -executable
RUN conda install -c conda-forge fastavro 
RUN conda install -c bioconda fasta3 
RUN conda install -c bioconda pyfasta 
 
RUN wget http://www.repeatmasker.org/utils/rmOutToGFF3.pl && PATH=~/rmOutToGFF3.pl:$PATH

RUN ls -la && wget http://exon.gatech.edu/Braker/BRAKER2.tar.gz && tar -xvf BRAKER2.tar.gz && cd BRAKER_v2.1.0 && chmod a+x *.pl && mv braker.pl  /miniconda/bin/ && export PATH='/home/BRAKER_v2.1.0/':$PATH && export PATH='/home/BRAKER_v2.1.0/braker.pl':$PATH

ENV export PATH=/home/BRAKER_v2.1.0/braker.pl:$PATH
ENV export PATH=/home/BRAKER_v2.1.0/:$PATH

RUN echo $PATH

#RUN cp /miniconda/share/RepeatMasker/BRAKER_v2.1.0/braker.pl /miniconda/share/RepeatMasker/ 

RUN conda install -c bioconda braker 
RUN conda install -c thiesgehrmann braker1 

RUN conda install -c biobuilds fasta
RUN conda install -c bioconda fasta3 

RUN wget http://faculty.virginia.edu/wrpearson/fasta/fasta36/fasta-36.3.7.tar.gz && tar -xvf fasta-36.3.7.tar.gz 
RUN cd fasta-36.3.7/ && ls -la && cd src/ && make -f ../make/Makefile.linux64_sse2 all && cd .. && cd bin/ && PATH=$PWD:$PATH 
RUN funannotate-1.0.0/funannotate check

