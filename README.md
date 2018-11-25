# spark

Apache Spark Docker Image - an update of the Google Container Registry Spark Image

## Description

This container is loosely based on gcr.io/google_containers/spark:1.5.2_v1. My main goal was to update the Spark version to the latest 2.3 stable, which is 2.3.2 at the time of this writing, and make an image that is a drop-in replacement for the GCR image. However, I recently re-did the image, switched to Alpine as the base, and dropped the Google Cloud Platform specific code. I suspect that GCP has changed so much since the gcr.io image that it was only of minimal use anyways.

The init scripts (start-worker and start-master) now call a little Python program (/write_configuration.py) that will scan the environment for any variables that begin with "spark." and write them to the /opt/spark/spark-defaults.conf file as per [https://spark.apache.org/docs/2.3.0/spark-standalone.html](https://spark.apache.org/docs/2.3.0/spark-standalone.html), so you can now configure Spark with wild abandon without messing with the image ... yay for that.

The compose directory contains a little Docker Compose configuration that will launch the spark-master and 2 workers. The README.md in the compose directory will walk you through a little demo if you are so inclined. 
