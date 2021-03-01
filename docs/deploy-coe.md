# Deploy Citrix ADC Observability Exporter

This topic provides information on how to deploy Citrix ADC Observability Exporter using Kubernetes YAML files.
<!---
You can deploy Citrix Observability Exporter using Kubernetes YAML files or using Helm charts. 
-->

Based on your Citrix ADC deployment, you can use Citrix ADC Observability Exporter to export metrics and transactions from Citrix ADC CPX, MPX, or VPX.

The following diagram shows a deployment of Citrix Observability Exporter with all the supported endpoints.

![Citrix ADC Observability Exporter with the endpoints](../media/citrix-observability-exporter-deploy.png)

Citrix ADC Observability Exporter supports the following endpoints: Kafka, Elasticsearch, Prometheus, and Zipkin. Depending on the endpoint that you require, you can deploy Citrix ADC Observability Exporter with that endpoint.

 You can use one of the following deployment procedures based on the endpoint that you require:

  -  [Deploy Citrix ADC Observability Exporter with Zipkin](deploy-coe-with-zipkin.md)

  -  [Deploy Citrix ADC Observability Exporter with Prometheus](deploy-coe-with-prometheus.md)

  -  [Deploy Citrix ADC Observability Exporter with Elasticsearch](deploy-coe-with-es.md)

  -  [Deploy Citrix ADC Observability Exporter with Kafka](deploy-coe-with-Kafka.md)