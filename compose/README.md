## Overview

This is a small Docker Compose configuration that will bring up the Spark Master and X Spark Workers. It is good for testing before you go out to Kubernetes and try to swim with the sharks.

## Demo Instructions

To start:

    sudo docker-compose up --scale spark-worker=2

Now hop into a different terminal window and launch a spark-shell on the spark-master you just started. Note that you can only use "spark-master" as the hostname because that hostname is set in the Docker compose file for the master. Otherwise spark-shell would error out with an error "Failed to connect to master spark-master:7070".

    sudo docker-compose exec spark-master /opt/spark/bin/spark-shell --master spark://spark-master:7077

That should churn for a bit and drop you into a shell that looks like this:

    Welcome to
          ____              __
         / __/__  ___ _____/ /__
        _\ \/ _ \/ _ `/ __/  '_/
       /___/ .__/\_,_/_/ /_/\_\   version 2.3.2
          /_/
             
    Using Scala version 2.11.8 (OpenJDK 64-Bit Server VM, Java 1.8.0_181)
    Type in expressions to have them evaluated.
    Type :help for more information.
    
    scala> 

yay

We can now walk through the [Spark Quickstart](https://spark.apache.org/docs/2.3.0/quick-start.html)

Grab the readme file, we will use the full path so as not to confuse the workers (or the master for that matter).

    scala> val textFile = spark.read.textFile("/opt/spark/README.md")  
    ... throw some misc warnings ...
    textFile: org.apache.spark.sql.Dataset[String] = [value: string]

Note that this ONLY WORKS because every worker, and the spark-shell, have access to the README.md file at the exact same path. If the spark-shell couldn't find the file it would throw an error. If the workers can't find the file you will get an error when you first try to run any operations .. like the below:

    scala> textFile.count()
    res0: Long = 103
    
    scala> textFile.first()
    res1: String = # Apache Spark
    
    scala> textFile.filter(line => line.contains("Spark")).count() // How many lines contain "Spark"?
    res2: Long = 20

Because we exposed port 8080 in the Docker Compose file you should be able to see Sparke Web UI by visiting http://localhost:8080 with your browser. Note that in the compose definition only the master has a sane hostname and exposed ports, because of this it is necessary to add the environmental variables to configure reverse proxy for each member of the Spark cluster, otherwise you would get errors when you tried to visit the workers using the WebUI. The settings work pretty well, except that the "Return to Master" link on the worker pages doesn't work, I can live with that.

    spark.ui.reverseProxy: "true"
    spark.ui.reverseProxyUrl: "spark-master"

When you are done exit out of the Spark shell with ctrl-d

    scala> :quit

Now go back to the terminal where you ran the original 'docker-compose up' command, take a moment to appreciate the output from the containers as they processed the above demo commands, and then hit ctrl-c to bring everything down.

    ^CGracefully stopping... (press Ctrl+C again to force)
    Stopping compose_spark-worker_2_1f10445d245e ... 
    Stopping compose_spark-worker_1_44fa87355b41 ... 
    Stopping compose_spark-master_1_c63d0a44b824 ... 
