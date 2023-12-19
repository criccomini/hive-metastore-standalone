FROM openjdk:8-slim

ARG HADOOP_VERSION=3.3.5
ARG HIVE_METASTORE_VERSION=3.1.3
ENV HADOOP_HOME="/opt/hadoop"

WORKDIR /app
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  echo "Install OS dependencies" && \
    build_deps="curl" && \
    apt-get update -y && \
    apt-get install -y $build_deps --no-install-recommends && \
  echo "Download and extract the Hadoop binary package" && \
    curl https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    | tar xvz -C /opt/ && \
    ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
    rm -r /opt/hadoop/share/doc && \
  echo "Download and install the standalone metastore binary" && \
    curl https://downloads.apache.org/hive/hive-$HIVE_METASTORE_VERSION/apache-hive-$HIVE_METASTORE_VERSION-bin.tar.gz \
    | tar xvz -C /opt/ && \
    ln -s /opt/apache-hive-$HIVE_METASTORE_VERSION-bin /opt/hive-metastore && \
  echo "Purge build artifacts" && \
    apt-get purge -y --auto-remove $build_deps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/hive-site.xml /opt/hive-metastore/conf/hive-site.xml
COPY run.sh run.sh

CMD [ "./run.sh" ]
