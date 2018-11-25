#!/usr/bin/python3
import os

try:
  fh = open('/opt/spark/conf/spark-defaults.conf','a')
  print("Writing Environmental Configuration to /opt/spark/conf/spark-defaults.conf")
  fh.write("\n##\n## Written from Environment by ./write_configuration.py on Spark Startup\n##\n")

  for idx,v in enumerate(os.environ):
    if v.startswith("spark."):
      fh.write("%s\t%s\n" % (v,os.environ[v]))      
      print("Configuring Spark: %s -> %s" % (v,os.environ[v]))

  fh.close()

except FileNotFoundError:
  print("Failed to find /opt/spark/conf/spark-defaults.conf for writing")
  sys.exit(1)

