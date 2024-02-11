# Description of configuration parameters

This topic contains descriptions of the `lstreamd_default.conf` file parameters. The `lstreamd_default.conf` parameters are used for endpoint specific configurations

-  `ServerUrl`: Specifies the address of the server.

    The protocol can be Kafka for Apache Kafka, HTTP or HTTPs for Splunk and ElasticSearch, and HTTP for Zipkin.

    The following are examples of how to specify the server URL for different end points:

    Kafka:

            kafka-server:9992
            1.2.3.4:10000
    Splunk:

            http://splunk-server:80
            https://splunk-server:443
            http://1.2.3.4:1000
            https://5.6.7.8:2000

    ElasticSearch:

            http://elastic-server:80
            https://elastic-server:443
            http://9.8.7.1:80
            https://1.2.3.5:3000
    Zipkin:

            http://zipkin-server:80
            http://1.2.3.4:80

-  `KafkaTopic`:

    Specifies the topic on a Kafka cluster for sending the transaction records. The default value is HTTP.

-  `DataFormat`:

    Specifies the format of the data sent over to Kafka. The values can be either JSON or AVRO.
    The default data format is AVRO.

-  `MaxConnections`:

    Specifies the maximum parallel TCP connections to an endpoint.
    The default value is 64.

-  `FileSizeMax`:

    For the Kafka endpoint, AVRO files are created and stored on the disk before they get pushed to the endpoint.
    This parameter specifies the size of each such file in Kibibyte (KiB). A file can contain multiple transaction records. The default value is 48 KiB.

-  `RecordType`:

    Specifies the types of records that you want to export:

    -  HTTP
    -  TCP
    -  SWG
    -  VPN
    -  ICA
    -  APPFW
    -  BOT
    -  VIDEOPT
    -  BURST_CQA
    -  SLA
    -  MONGO
    -  MQTT

    Citrix ADC Observability Exporter allows filtering of transaction records of various insights.
    By default, none of the records are exported.
    You must set these fields appropriately to export the required records.
    Examples :

        "TCP": "all",
        "SWG": "none",
        "APPFW": "all"

-  `EVENTS`:

    Citrix ADC Observability Exporter allows exporting time series (events, and audit logs) to Splunk and Kafka.
    Set this field to `yes` to allow exporting events.
    The default value is `no`.

-  `AUDITLOGS`:

    You can export audit logs to Splunk and Kafka.
    Set this field to `yes` to allow exporting audit logs.
    The default value is `no`.

-  `ConnectionPoolSize`:

    Alters the size of connection pools for Splunk.`ConnectionPoolSize` and `MaxConnections` can be used to control the rate at which data is exported (to the endpoint).

-  `ElkMaxSendBuffersPerSec`:

    The maximum rate at which the data is exported to ElasticSearch.
    An ELK JSON Buffer is 32 KiB in size.
    This field configures the maximum number of ELK buffers exported every second.
    The default value is 64.

-  `transRateLimitEnabled`:

    Sometimes, the incoming traffic may increase and Citrix Observability Exporter may not be able to scale up to it.
    In such cases, export to JSON endpoints like Splunk, ElasticSearch, and Zipkin over HTTP/HTTPS might become a bottleneck.
    The memory would keep growing uncontrollably until Citrix Observability Exporter terminates.
    To avoid such scenarios, rate-limiting can be configured for JSON based endpoints including Kafka. The impact on Kafka is low as Kafka is an efficient protocol.
    Set this field to `yes` to enable rate-limiting for JSON based end points.
    The default value is `no`.

-  `transQueueLimit`:

    Specifies the number of JSON buffers that can be accumulated before Citrix Observability Exporter starts discarding them.
    For Zipkin, one JSON buffer is about 64 KiB and a limit of 1000 means approximately 64 MB of JSON data.
    For Splunk and ElasticSearch, one JSON buffer is about 32 KiB and a limit of 1000 means approximately 32 MB of data.
    The default value is 1024.

-  `transRateLimitWindow`:

    Specifies the recalculation window in seconds and the value must be greater than zero.
    The lower the window size, the more effective is the rate-limiting, but specifying low values may cause slight CPU overhead.
    The default value is five seconds.

-  `AuthToken`:

    You can use the auth token to perform the token-based authentication for Splunk.
    It can also be used for password-based authentication for ElasticSearch.

    Examples :

        SPLUNK

            "AuthToken": "xxxxxxxx-xxxx-xxxx-ad58-1ce9bdeee09a"
        
        ELASTICSEARCH

            "AuthToken": "ZWxhc3RpYzpteXBhc3MxMjM="

-  `Index`:

    The Splunk index where the processed data is stored.
     The default value is "". That means the default index.

-  `IndexPrefix`:

    Specifies the index prefix used for ElasticSearch. ElasticSearch allows you to create indexes as necessary through its APIs.
    Kibana allows the creation of index patterns and to facilitate that, this field is used.
    All index names follow this prefix followed by the time of creation of the index. The time or time format is based on the `IndexInterval`.

-  `IndexInterval`:

    The interval at which the ElasticSearch indexes are rotated, following the index pattern.
    You can configure the interval as one of the following values:

    -  hourly
    -  12 hours
    -  daily
    -  weekly
    -  2 weeks
    -  monthly
    -  6 months
    -  yearly

    The default value is "". That means, the index never rotates.

## Additional information

Following are the guidelines while configuring the  `lstreamd_default.conf` file parameters.

-  Zipkin is supported in parallel to Splunk, ElasticSearch, or Kafka.

-  You do not need to configure Prometheus as it is pull based. Citrix ADC observability exporter exports NetScaler metrics and its own metrics to prometheus.

    Port 5563 of the container can be scraped using insecure HTTP at the path '/metrics'.

    For example:

        http://coe-fqdn:5563/metrics

    Prometheus is always `ON` and metrics can be exported to it in parallel to transactions, audit logs, and events.

-  Currently, you can only export time series like audit logs and events to Splunk and Kafka, but in parallel to transactions and metrics.

-  You must not configure multiple endpoints of the same type in the `lstreamd_default.conf` file for one Citrix ADC Observability Exporter. For example, it is not possible to configure two Splunk instances, or two Kafka instances, or two ElasticSearch instances, or one Splunk and one ElasticSearch, and so on.
    For Zipkin, although you can configure it in parallel to Splunk and ElasticSearch, you may not configure multiple instances of Zipkin. For example, it is not possible to have two Zipkin instances in parallel.

-  You can ignore the fields that are marked as optional as some of them may have predefined default values.

-  The JSON parser used for `lstreamd_default.conf` is extremely sensitive (also case-sensitive). Ensure that you do not have extra or missing commas, or anything that may make the JSON format invalid.

-  Some of the `lstreamd_default.conf` file parameters are not listed in this document. Those parameters that are not listed are internal and are not meant to be altered. They have predefined default values.