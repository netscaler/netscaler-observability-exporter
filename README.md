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

  -  [Deploy Citrix ADC Observability Exporter with Zipkin](https://github.com/citrix/citrix-observability-exporter/blob/master/docs/deploy-coe-with-zipkin.md)

  -  [Deploy Citrix ADC Observability Exporter with Prometheus](https://github.com/citrix/citrix-observability-exporter/blob/master/docs/deploy-coe-with-prometheus.md)

  -  [Deploy Citrix ADC Observability Exporter with Elasticsearch](https://github.com/citrix/citrix-observability-exporter/blob/master/docs/deploy-coe-with-es.md)

  -  [Deploy Citrix ADC Observability Exporter with Kafka](https://github.com/citrix/citrix-observability-exporter/blob/master/docs/deploy-coe-with-Kafka.md)

  -  [Deploy Citrix ADC Observability Exporter with Splunk](https://github.com/citrix/citrix-observability-exporter/blob/master/docs/deploy-coe-with-splunk.md)

## Questions and support

For questions and support, the following channels are available:

-  [Citrix Discussion Forum](https://discussions.citrix.com/)
-  [Citrix ADC Cloud Native Slack Channel](https://citrixadccloudnative.slack.com/)
  
To request an invitation to participate in the Slack channel, provide your email address using this form: [https://podio.com/webforms/22979270/1633242](https://podio.com/webforms/22979270/1633242)

 For more information about Citrix cloud native solutions, you can reach out to the Citrix product team at: AppModernization@citrix.com

![ ](media/contact-product-team.png)

## Issues

Describe issues in detail, collect logs, and use the [discussion forum](https://discussions.citrix.com/forum/1657-netscaler-cpx/) to raise the issue.

## Code of Conduct

This project adheres to the [Kubernetes Community Code of Conduct](https://github.com/kubernetes/community/blob/master/code-of-conduct.md). By participating in this project, you agree to abide by its terms.
