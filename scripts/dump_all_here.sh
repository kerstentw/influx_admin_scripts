exchanges=$(curl -s "localhost:8086/query?q=SHOW%20DATABASES" | jq '.results[0].series[0].values[][]')

for wrd in $exchanges
  do
    cut_string=$(echo "$wrd" | cut -d'"' -f 2)
    influxd backup -database "$cut_string" ../dumps
  done

