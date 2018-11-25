FROM gcr.io/google_containers/spark:1.5.2_v1
MAINTAINER Jeff Harwell <jeff.harwell@gmail.com>

## This is, of course, non-ideal.
## If I had the dockerfile for the GCR image I would do this differently
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Grab and unpack Spark 1.6.3
## https://spark.apache.org/downloads.html
RUN wget https://archive.apache.org/dist/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz && \
    tar -xvf ./spark-2.3.2-bin-hadoop2.7.tgz && \
    mkdir /config_backup && \
    cp /opt/spark/conf/* /config_backup && \
    cp /opt/spark/lib/gcs-connector-latest-hadoop2.jar /config_backup && \
    rm -fr /opt/spark-1.5.2-bin-hadoop2.6 && \
    rm /opt/spark && \
    mv ./spark-2.3.2-bin-hadoop2.7 /opt/ && \
    ln -s /opt/spark-2.3.2-bin-hadoop2.7 /opt/spark && \
    cp /config_backup/core-site.xml /opt/spark/conf && \
    cp /config_backup/log4j.properties /opt/spark/conf && \
    cp /config_backup/spark-defaults.conf /opt/spark/conf && \
    cp /config_backup/gcs-connector-latest-hadoop2.jar /opt/spark/lib && \
    rm -fr /config_backup && \
    rm ./spark-2.3.2-bin-hadoop2.7.tgz

RUN rm -rf /tmp/* /var/tmp/*
