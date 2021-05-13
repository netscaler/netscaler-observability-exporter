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
              - ./cores/:/cores/:rw
        ```

2.  Create `lstreamd_default.conf` file with the required settings. The following is a sample configuration for the Elasticsearch endpoint speific deployment.

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

3.  Run the `docker-compose up` command.

Citrix ADC Observability Exporter is deployed and exposed on port 5557 and port 5563 for Citrix ADC transaction data and metrics data respectively.