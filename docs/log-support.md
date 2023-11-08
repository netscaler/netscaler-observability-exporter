# Support for container logging

Now, you can enable logging on NetScaler Observability Exporter according to different severity levels. These logs help in getting information about endpoint specific configuration.

The following logging severity levels are supported and the default value is `INFO`.

-  `NONE` : None of the messages are logged.
-  `FATAL` : Only fatal messages are logged.
-  `ERROR`:  Only fatal messages and error messages are logged.
-  `INFO`:  Only fatal, error, and informational messages are logged.

For Kubernetes YAML based deployments the default value is NONE. But, for Helm and OpenShift operator deployments of NetScaler Observability Exporter logging is enabled by default and set as INFO.

You can configure logging using the environment variable `NSOE_LOG_LEVEL` while deploying NetScaler Observability Exporter for each endpoint.

The following example shows how to configure the log level in the NetScaler Observability Exporter deployment YAML:

         env:
           - name: NSOE_LOG_LEVEL
             value: "INFO"

The following are the types of logs that you can get:

-  NetScaler Observability Exporter configuration file errors and parsing errors.
-  Endpoint (ElasticSearch, Splunk) status such as up or down.
-  Endpoint specific configuration errors. For example, the message saying `Kafka topic is invalid`.
-  NetScaler related configuration messages. For example, adding or deleting a NetScaler IP address.