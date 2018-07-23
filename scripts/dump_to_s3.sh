# s3Dump.sh

date=`date +%Y-%m-%d`
dateFormatted=`date -R`

s3Bucket="influxdumps"

#s3.config:
#s3AccessKey= <YOUR ACCESS KEY FOR S3 IAM>
#s3SecretKey="<YOUR SECRET FOR S3 IAM>"

keys=$(cat ./configs/s3.config)
export $keys

echo "My Keys: $s3AccessKey; $s3SecretKey"

file_num=$(ls -l ./dumps| wc -l | sed 's/^ *//')
cur_iteration=1
uname=$(uname)
folder="${uname}-${date}"

for file in ./dumps/*
    do
        basefile=$(basename $file)
        printf "\n${folder} ($cur_iteration/$file_num) Uploading $basefile"
        cur_iteration=$(expr $cur_iteration + 1)

        bucketPath="/${s3Bucket}/${folder}/${basefile}"
        contentType="application/octet-stream"
        stringToSign="PUT\n\n$contentType\n$dateFormatted\n$bucketPath"
        signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3SecretKey} -binary | base64`

        curl -X PUT -T "${file}" \
        -H "Host: ${s3Bucket}.s3.amazonaws.com" \
        -H "Date: ${dateFormatted}" \
        -H "Content-Type: ${contentType}" \
        -H "Authorization: AWS ${s3AccessKey}:$signature" \
        http://${s3Bucket}.s3.amazonaws.com/${folder}/${basefile}

    done

printf "...Finished\n"
