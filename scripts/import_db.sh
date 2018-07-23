sudo service influxdb stop  (Service should not be running)
influxd restore ../dumps
sudo service influxdb start
