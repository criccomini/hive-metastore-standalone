# Hive Metastore Standalone Docker Image 🐝 🐳

This repo creates a Docker image of a completely standalone Hive Metastore suitable for running in a Github Workflow or as a Docker image without the need for compose.

Unlike other Hive Metastore Docker images, this Docker image can be run without any other containers.

* ✅ No S3
* ✅ No localstack
* ✅ No minio
* ✅ No PostgreSQL
* ✅ No Hive
* ✅ No Hadoop
* ✅ No other containers

The image uses [Hive Metastore Standalone]([url](https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive)) configured to run [embedded Derby](https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+Administration#AdminManualMetastoreAdministration-Local/EmbeddedMetastoreDatabase(Derby)) for the DB and the local filesystem for the FS.

_NOTE: Only one process can connect to the metastore at a time because embedded Derby only supports one connection at a time. This should be fine for integration tests._

## Usage

The package is published to the [Github Container Registry](https://github.com/recap-build/hive-metastore-standalone/pkgs/container/hive-metastore-standalone).

```
docker pull ghcr.io/recap-build/hive-metastore-standalone:latest
```

## Github Workflow

You can use the Hive Metastore for integration tests in your [Github Workflows](https://docs.github.com/en/actions/using-workflows) using this service block:

```yaml
    services:
      hive-metastore:
        image: ghcr.io/recap-build/hive-metastore-standalone:latest
        ports:
          - 9083:9083
```

## Acknowledgements

This image is based on [@naushadh](https://github.com/naushadh)'s [hive-metastore](https://github.com/naushadh/hive-metastore) repo.
