FROM docker.io/ubuntu:18.04

MAINTAINER Simon Urbanek <simon.urbanek@R-project.org>

RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
apt-transport-https dirmngr gpg-agent \
software-properties-common \
curl \
git \
gcc g++ gfortran libcairo-dev libreadline-dev libxt-dev libjpeg-dev \
libicu-dev libssl-dev libcurl4-openssl-dev subversion git automake make libtool \
libtiff-dev gettext \
locales \
&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 381BA480
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran35/"
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install -q -y r-base-dev r-recommended \
&& echo 'options(repos = c(CRAN = "https://cloud.r-project.org"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
&& rm -rf /var/lib/apt/lists/*

CMD ["R"]
