# Vancouver Graffiti Analysis Dockerfile
# author: Kangbo Lu, Mengyuan Zhu, Mitchie Zhao, Siqi Zhou
# date: 2020-12-11
# usage for build with a new tag:
#   docker build --tag YOUR_TAG_HERE
# usage for run your build:
#   docker run -it --rm YOUR_TAG_HERE

# base docker image
FROM debian:stable

# download miniconda for python 3 and install python 3.8.3
RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3.8.3 \
    && conda update conda
ENV PATH /opt/conda/bin:$PATH

# install package for python
RUN conda install docopt=0.6.2 requests=2.23.0 pandas=1.1.1
RUN conda clean --yes --all

# install R 4.0.3
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get install dirmngr -y
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
RUN add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian buster-cran40/'
RUN apt-get update
RUN apt-get install r-base r-base-dev -y

# install packages for R
RUN apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev -y
RUN Rscript -e "install.packages(c('tidyverse', 'devtools', 'rmarkdown'), Ncpus = 4)"
RUN Rscript -e "install.packages(c('docopt', 'RCurl', 'infer'), Ncpus = 4)"
RUN apt-get install pandoc -y
RUN apt-get install pandoc-citeproc -y