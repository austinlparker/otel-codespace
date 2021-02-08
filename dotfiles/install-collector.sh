#!/bin/bash
if [ "${CODESPACES}" != "true" ]; then
    echo 'Not in a codespace. Aborting.'
    exit 0
fi

sed -i -e 's/TOKEN/$LS_ACCESS_TOKEN/g' collector-config.yaml
ln -s "$(pwd)/collector-config.yaml" $HOME/collector-config.yaml

OTEL_COLLECTOR_VERSION=0.19.0
OTEL_COLLECTOR_URL=https://github.com/open-telemetry/opentelemetry-collector-contrib/releases/download/v$OTEL_COLLECTOR_VERSION/otelcontribcol_linux_amd64
OTEL_COLLECTOR_PATH=/var/tmp/otelcontribcol
wget $OTEL_COLLECTOR_URL -O $OTEL_COLLECTOR_PATH
chmod +x $OTEL_COLLECTOR_PATH

nohup /var/tmp/otelcontribcol --config=$HOME/collector-config.yaml & disown