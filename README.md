s3local
=======

Forked from [camjackson/fake-s3](https://github.com/camjackson/fake-s3)

[jubos/fake-s3](https://github.com/jubos/fake-s3/)

[saltzmanjoelh/fake-s3](https://github.com/saltzmanjoelh/fake-s3)

[lphoward/fake-s3](https://github.com/lphoward/fake-s3/)

Deploys [fake-s3](https://github.com/jubos/fake-s3) in a Docker container.

Image also contains **aws-cli** to allow data transfer from AWS into the local s3

Build docker image

    docker build -t s3local \
     --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
     --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

* AWS credentials may be used to synchronize data from AWS


Run docker

        docker run --name s3local -d s3local

Service exposed on port **80**.  Credentials are ignored.
Hostname used is **s3.localhost**

See [fake-s3](https://github.com/jubos/fake-s3) README for details/limitations.


### initializing s3local
Once docker starts running **fakes3**, an initialization script is executed,
the script `init_s3.sh` allows you to create buckets in advance before the service starts running.
It also allows you to synchronize data from live AWS S3 into your local S3
```
#!/usr/bin/env bash

# list all buckets to create
declare -a bucketNames=(
  "bucket1"
  "bucket2"
  ...
  "bucketN"
)

for bucketName in "${bucketNames[@]}"
do
    ./create_bucket.sh ${bucketName}
done


# synchronize data from AWS S3 into s3local

echo "sync bucket1 from production"
# download from AWS
aws --region us-west-1 s3 cp s3://bucket1 /tmp/bucket1 --recursive
# upload into s3local
aws --endpoint-url='http://localhost' s3 cp /tmp/bucket1 s3://bucket1 --recursive

``` 

### remotely create bucket
    docker exec -i s3local ./create_bucket.sh bucketname_to_create

### connecting via AWS-cli
    aws --endpoint-url='http://localhost*' s3 ...
    aws --endpoint-url='http://localhost*' s3api ...
* port 80 used here, if `-p PORT` used, url should become `http://localhost:PORT`

### connecting via AWS-lib

```scala
AmazonS3ClientBuilder
      .standard()
      .withCredentials(credentialsProvider)
      .withEndpointConfiguration(new EndpointConfiguration(s3Endpoint, regionName))
      .withPathStyleAccessEnabled(true)
      .disableChunkedEncoding()
      .build()
```