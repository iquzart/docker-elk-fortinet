#!/bin/bash

curl -XGET 'localhost:9200/_cat/indices?v&pretty' | awk '{ print $3}' | sort -n | grep logstash-syslog > /tmp/file.txt

readarray -t array < /tmp/file.txt

for i in "${array[@]:0:30}"
do
        todelete=$i
        /usr/bin/curl -XDELETE http://127.0.0.1:9200/$todelete
        echo "Index $todelete deleted"
done

rm -rf /tmp/file.txt
