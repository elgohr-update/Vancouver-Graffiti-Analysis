FROM debian:latest

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

# define repo url for cran image snapshot
#ARG repo_url = 'https://mran.revolutionanalytics.com/snapshot/2020-12-11/'

# install packages for R
#RUN Rscript -e "install.packages(c('docopt', 'RCurl', 'knitr', 'infer', 'ggplot2'), repos = $repo_url)"