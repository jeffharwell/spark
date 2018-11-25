#!/bin/bash

sudo docker run -it --rm --entrypoint="" -e "spark.ui.reverseProxy=false" -e "spark.ui.reverseProxyUrl=true" -e "spark.driver.memory=2g" -e "spark.executor.memory=3g" --network sparknetwork --name spark jeffharwell/spark:2.3.2_v2 /bin/sh
