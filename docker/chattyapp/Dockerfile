FROM python:2.7
MAINTAINER William Tseng "<tseng@adobe.com>"

RUN groupadd -r web && useradd -r -g web web && \
    mkdir /home/web && \
    chown web:web /home/web
COPY ./src/chatty.py /home/web
WORKDIR /home/web
CMD python /home/web/chatty.py
