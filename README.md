# OpenTelemetry Test Harness

## Build

```bash
docker build -t opentelemetry-ruby-testharness .    
```

## Run

Ensure you have an OLTP server running and you know the endpoint address to which traces should be sent.

```bash
docker run -it -e OTEL_EXPORTER_OTLP_ENDPOINT='http://host.docker.internal:4318' -p 4567:4567 opentelemetry-ruby-testharness
curl http://localhost:4567/stevie-says/relax
```

NB: don't forget to update the `OTEL_EXPORTER_ENDPOINT` environment variable in the `docker run` command above.

## Running a Local OTEL Collector (Optional)

```bash
git clone git@github.com:open-telemetry/opentelemetry-ruby.git; \
cd opentelemetry-ruby/examples/otel-collector; \
docker-compose up -d
```
