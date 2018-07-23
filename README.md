# InfluxDB S3 Backup Scripts

*For Unix Based Systems Only*

This suite of scripts will allow you to dump an entire Influx database (including metadata) to an S3 instance of your choice.  You may need to edit the bucketname which defaults to s3:influxdumps in the dump_to_s3.sh file.

* Create a file with the following syntax for your s3 keys:

```shell
s3.config

s3AccessKey=<YOUR_ACCESS_KEY>
s3SecretKey=<YOUR_SECRET_KEY>
```

* Place the file named s3.config in the root/configs folder.

* A gitignore has already been created for you that will keep this file from being uploaded to git.

* Run Export.sh directly from directory with a running instance of influx to back up the entire database

**TO DO:**
* **Spin all Config into config dir**

