#!/usr/bin/env bash

set -euxo pipefail

# run schematool
/opt/hive-metastore/bin/schematool --verbose -dbType derby -initSchema

# start metastore (in foreground)
/opt/hive-metastore/bin/start-metastore