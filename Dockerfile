FROM gcr.io/google_containers/spark:1.5.2_v1
MAINTAINER Jeff Harwell <jeff.harwell@gmail.com>

## This is, of course, non-ideal.
## If I had the dockerfile for the GCR image I would do this differently
RUN apt-get -y update
RUN apt-get -y upgrade

## Grab and unpack Spark 1.6.3
## https://spark.apache.org/downloads.html
RUN wget http://www.trieuvan.com/apache/spark/spark-1.6.3/spark-1.6.3-bin-hadoop2.6.tgz && \
    tar -xvf ./spark-1.6.3-bin-hadoop2.6.tgz

## Backup the configuration
RUN mkdir /config_backup && \
    cp /opt/spark/conf/* /config_backup

## Install the new version
RUN rm -fr /opt/spark-1.5.2-bin-hadoop2.6 && \
    rm /opt/spark && \
    mv ./spark-1.6.3-bin-hadoop2.6 /opt/ && \
    ln -s /opt/spark-1.6.3-bin-hadoop2.6 /opt/spark

## Install the configuration
RUN cp /config_backup/core-site.xml /opt/spark/conf && \
    cp /config_backup/log4j.properties /opt/spark/conf && \
    cp /config_backup/spark-defaults.conf /opt/spark/conf

## Cleanup
RUN rm -fr /config_backup
RUN rm ./spark-1.6.3-bin-hadoop2.6.tgz
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
