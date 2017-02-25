FROM centos:7
MAINTAINER William Tseng "<tseng@adobe.com>"

RUN yum install -y python
RUN yum install -y epel-release
RUN yum install -y python-pip
RUN pip install requests
RUN groupadd -r web && useradd -r -g web web && \
    mkdir /home/web && \
    chown web:web /home/web
COPY ./src/chatty.py /home/web
WORKDIR /home/web
CMD python /home/web/chatty.py
