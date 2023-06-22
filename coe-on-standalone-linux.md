# Deploy Citrix ADC Observability Exporter on Linux using Docker Compose

You can deploy Citrix ADC Observability Exporter as a container on a Docker system in stand-alone Linux using the docker compose tool. To deploy Citrix ADC Observability Exporter on a Linux machine using Docker Compose, you must create a `docker-compose.yaml` and a `lstreamd_default.conf` file with the required settings.

### Prerequisites

  -  Ensure that the Docker version 19 or later is running on the Linux machine.
  -  Ensure that the Docker Compose version 1.17.1 or later is installed.

## Deploy Citrix ADC Observability Exporter on Linux

Perform the following steps to deploy Citrix ADC Observability Exporter on a standalone Linux using the Docker Compose tool:

1.  Create a `docker-compose.yaml` file in the desired director space with the following data:

      ```yml
        version: "3.3"
        services:
          coe:
            container_name: coe-latest
            image:  "quay.io/citrix/citrix-observability-exporter:latest"
            ports:
              - 5557:5557
              - 5563:5563
            privileged: true
            volumes:
              - ./lstreamd_default.conf:/var/logproxy/lstreamd/conf/lstreamd_default.conf:rw
              - ./cores:/var/crash/:rw
      ```

    **Note:** Currently the image tag `quay.io/citrix/citrix-observability-exporter:latest` corresponds to Citrix ADC Observability Exporter version 1.2.001 and not 1.4.001.

2.  Create the `lstreamd_default.conf` file with the required settings.

    -  Following is a sample configuration for Elasticsearch endpoint specific deployment:

            {
                    "Endpoints": {
                        "ES": {
                            "ServerUrl": "elasticsearch.default.svc.cluster.local:9200",
                            "IndexPrefix":"adc_coe",
                            "IndexInterval": "daily",
                            "RecordType": {
                                "HTTP": "all",
                                "TCP": "all",
                                "SWG": "all",
                                "VPN": "all",
                                "NGS": "all",
                                "ICA": "all",
                                "APPFW": "none",
                                "BOT": "none",
                                "VIDEOOPT": "none",
                                "BURST_CQA": "none",
                                "SLA": "none",
                                "MONGO": "none"
                            },
                            "ProcessAlways": "no",
                            "ProcessYieldTimeOut": "500",
                            "MaxConnections": "512",
                            "ElkMaxSendBuffersPerSec": "64",
                            "JsonFileDump": "no"
                        }
                    }
            }

    -  Following is a sample configuration for Elasticsearch endpoint specific deployment with Prometheus. For Citrix ADC Observability Exporter version 1.4.001, you should add `"PrometheusMode": "yes"` to the Elasticsearch `lstreamd_default.conf` file to enable Prometheus monitoring.

            {
                    "Endpoints": {
                        "ES": {
                            "ServerUrl": "elasticsearch.default.svc.cluster.local:9200",
                            "IndexPrefix":"adc_coe",
                            "IndexInterval": "daily",
                            "RecordType": {
                                "HTTP": "all",
                                "TCP": "all",
                                "SWG": "all",
                                "VPN": "all",
                                "NGS": "all",
                                "ICA": "all",
                                "APPFW": "none",
                                "BOT": "none",
                                "VIDEOOPT": "none",
                                "BURST_CQA": "none",
                                "SLA": "none",
                                "MONGO": "none"
                            },
                            "ProcessAlways": "no",
                            "ProcessYieldTimeOut": "500",
                            "MaxConnections": "512",
                            "ElkMaxSendBuffersPerSec": "64",
                            "JsonFileDump": "no",
                            "PrometheusMode": "yes"
                        }
                    }
            }

3.  Run the `docker-compose up` command.

Citrix ADC Observability Exporter is deployed and exposed on port 5557 and port 5563 for Citrix ADC transaction data and metrics data respectively.

### Prometheus standalone deployment

For Citrix ADC observability exporter version 1.4.001, with Prometheus as the endpoint you need to use the following `lstreamd_default.conf` file configuration.

            lstreamd_default.conf: |
            {
                "Endpoints": {
                    "ZIPKIN": {
                                "ServerUrl":"http://0.0.0.0:0",
                                "RecordType":{},
                                "PrometheusMode":"yes"
                              }
                     }
            }

For Citrix ADC observability exporter versions prior to 1.4.001, you can use the `lstream_default.conf` configuration provided in the [coe-prometheus.yaml](https://github.com/citrix/citrix-observability-exporter/blob/master/deployment/coe-prometheus.yaml) file.

## Integrate Citrix ADC with multiple Citrix ADC Observability Exporter instances manually

You can configure Citrix ADC Observability Exporter manually in Citrix ADC. Manual configuration is suitable for Citrix ADC in MPX and VPX form factors. We recommend deploying the Citrix ADC Observability Exporter in the automated way with the YAML file as described in the preceding sections.

For information about deploying Citrix ADC Observability Exporter (coe-kafka.yaml) and web application (webserver-kafka.yaml), see the preceding sections.

```
enable feature appflow
enable ns mode ULFD
add service COE_svc1 <COE IP1> LOGSTREAM <COE PORT1>
add service COE_svc2 <COE IP2> LOGSTREAM <COE PORT2>
add service COE_svc3 <COE IP3> LOGSTREAM <COE PORT3>
add lb vserver COE LOGSTREAM 0.0.0.0 0
bind lb vserver COE COE_svc1
bind lb vserver COE COE_svc2
bind lb vserver COE COE_svc3
add analytics profile web_profile -collectors COE -type webinsight -httpURL ENABLED -httpHost ENABLED -httpMethod ENABLED -httpUserAgent ENABLED -httpContentType ENABLED
add analytics profile tcp_profile -collectors COE -type tcpinsight
bind lb/cs vserver <WEB-PROXY> -analyticsProfile web_profile
bind lb/cs vserver <WEB-PROXY> -analyticsProfile tcp_profile
 
# To enable metrics push to prometheus
add service metrichost_SVC <IP> HTTP <PORT>
set analyticsprofile ns_analytics_time_series_profile -collectors metrichost_SVC -metrics ENABLED -outputMode prometheus

```

Add Citrix ADC Observability Exporter using FQDN

```
enable feature appflow
enable ns mode ULFD
add dns nameserver <KUBE-CoreDNS>
add server COEsvr <FQDN>
add servicegroup COEsvcgrp LOGSTREAM  -autoScale DNS
bind servicegroup COEsvcgrp COEsvr <PORT>
add lb vserver COE LOGSTREAM 0.0.0.0 0
bind lb vserver COE COEsvcgrp
add analytics profile web_profile -collectors COE -type webinsight -httpURL ENABLED -httpHost ENABLED -httpMethod ENABLED -httpUserAgent ENABLED -httpContentType ENABLED
add analytics profile tcp_profile -collectors COE -type tcpinsight
bind lb vserver <WEB-VSERVER> -analyticsProfile web_profile
bind lb vserver <WEB-VSERVER> -analyticsProfile tcp_profile
 
 # To enable metrics push to prometheus
add service metrichost_SVC <IP> HTTP <PORT>
set analyticsprofile ns_analytics_time_series_profile -collectors metrichost_SVC -metrics ENABLED -outputMode prometheus

```

For information on troubleshooting related to Citrix ADC Observability Exporter, see [Citrix ADC CPX troubleshooting](https://docs.citrix.com/en-us/citrix-adc-cpx/current-release/cpx-troubleshooting.html).
