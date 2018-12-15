FROM camjackson/fake-s3
MAINTAINER Ori Yechieli

RUN apt-get update && \
    apt-get install -y python-pip && \
    pip install awscli

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

RUN aws --version

COPY create_bucket.sh /create_bucket.sh
COPY init_s3.sh /init_s3.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--root",  "/fakes3_root", "--hostname", "s3.localhost", "--port",  "80"]
EXPOSE 80
