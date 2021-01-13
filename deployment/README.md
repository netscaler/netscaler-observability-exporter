# Deploy Citrix Observability Exporter

This topic provides information on how to deploy Citrix Observability Exporter using Kubernetes YAML files.
<!---
You can deploy Citrix Observability Exporter using Kubernetes YAML files or using Helm charts. 
-->

Based on your Citrix ADC deployment, you can use Citrix Observability Exporter to export metrics and transactions from Citrix ADC CPX, MPX, or VPX.

The following diagram shows a deployment of Citrix Observability Exporter with all the supported endpoints.

![Citrix Observability Exporter](../media/citrix-observability-exporter-deploy.png)

Citrix ADC Observability Exporter supports endpoints: Kafka, Elasticsearch, Prometheus, and Zipkin. Depending on the endpoint that you require, you can deploy Citrix ADC Observability Exporter with that endpoint. You can use the following the deployment procedure based on the endpoint that you selected.

  [Deploy Citrix ADC Observability Exporter with Kafka](../docs/deploy-coe-with-Kafka.md)

  [Deploy Citrix ADC Observability Exporter with Elasticsearch](../docs/deploy-coe-with-es.md)

  [Deploy Citrix ADC Observability Exporter with Prometheus](../docs/deploy-coe-with-prometheus.md)

  [Deploy Citrix ADC Observability Exporter with Zipkin](../docs/deploy-coe-with-zipkin.md)