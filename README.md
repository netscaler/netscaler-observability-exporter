# Citrix ADC Observability Exporter

 Citrix ADC Observability Exporter is a container which collects metrics and transactions from Citrix ADCs and transforms them to suitable formats (such as JSON, AVRO) for [supported endpoints](#Supported-Endpoints). You can export the data collected by Citrix Observability Exporter to the desired endpoint. By analyzing the data exported to the endpoint, you can get valuable insights at a microservices level for applications proxied by Citrix ADCs.

## Supported Endpoints

 Citrix ADC Observability Exporter currently supports the following endpoints:

 - [Zipkin](https://zipkin.io/)
 - [Kafka](https://kafka.apache.org/)
 - [Elasticsearch](https://www.elastic.co/products/elasticsearch)
 - [Prometheus](https://prometheus.io/docs/introduction/overview/)
 - [Splunk Enterprise](https://www.splunk.com/en_us/software/splunk-enterprise/features.html)

## Overview

### Distributed tracing support with Zipkin

In a microservice architecture, a single end-user request may span across multiple microservices and tracking a transaction and fixing sources of errors is challenging. In such cases, traditional ways for performance monitoring cannot accurately pinpoint where failures occur and what is the reason behind poor performance. You need a way to capture data points specific to each microservice which is handling a request and analyze them to get meaningful insights.

Distributed tracing addresses this challenge by providing a way to track a transaction end-to-end and understand how it is being handled across multiple microservices. [OpenTracing](https://opentracing.io/) is a specification and standard set of APIs for designing and implementing distributed tracing. Distributed tracers allow you to visualize the data flow between your microservices and helps to identify the bottlenecks in your microservices architecture.

Citrix ADC Observability Exporter implements distributed tracing for Citrix ADC and currently supports [Zipkin](https://zipkin.io/) as the distributed tracer.

Currently, you can monitor performance at the application level using Citrix ADC. Using Citrix ADC Observability Exporter with Citrix ADC, you can get tracing data for microservices of each application proxied by your Citrix ADC CPX, MPX, or VPX.

### Transaction collection and streaming support

Citrix ADC Observability Exporter supports collecting transactions and streaming them to endpoints. Currently, Citrix ADC Observability Exporter supports Elasticsearch, Prometheus, Zipkin, Splunk Enterprise and Kafka as transaction endpoints.

### Time series data support

Citrix ADC Observability Exporter supports collecting time series data (metrics) from Citrix ADC instances and exports them to Prometheus. Prometheus is a monitoring solution for storing time series data like metrics. You can then add Prometheus as a data source to Grafana and graphically view the Citrix ADC metrics and analyze the metrics.

## How does Citrix ADC Observability Exporter work

### Distributed tracing with Zipkin using Citrix ADC Observability Exporter

Logstream is a Citrix-owned protocol that is used as one of the transport modes to efficiently transfer transactions from Citrix ADC instances. Citrix ADC Observability Exporter collects tracing data as Logstream records from multiple Citrix ADCs and aggregates them. Citrix ADC Observability Exporter converts the data into a format understood by the tracer and then uploads to the tracer (Zipkin in this case). For Zipkin, the data is converted into JSON, with Zipkin-specific key values.

You can view the traces using the Zipkin user interface. However, you can also enhance the trace analysis by using [Elasticsearch](https://www.elastic.co/products/elasticsearch) and [Kibana](https://www.elastic.co/products/kibana) with Zipkin. Elasticsearch provides long-term retention of the trace data and Kibana allows you to get much deeper insight into the data.

### Citrix ADC Observability Exporter with Elasticsearch as the transaction endpoint

When Elasticsearch is specified as the transaction endpoint, Citrix ADC Observability Exporter converts the data to JSON format. On the Elasticsearch server, Citrix ADC Observability Exporter creates Elasticsearch indexes for each ADC on an hourly basis. These indexes are based on data, hour, UUID of the ADC, and the type of HTTP data (http_event or http_error). Then, Citrix ADC Observability Exporter uploads the data in JSON format under Elastic search indexes for each ADC. All regular transactions are placed into the http_event index and any anomalies are placed into the http_error index.  

Effective with the Citrix ADC Observability Exporter release 1.2.001, when the Citrix ADC Observability Exporter sends the data to the Elasticsearch server some of the fields are available in the string format. Also, index configuration options are also added for Elasticsearch. For more information on fields which are in the string format and how to configure the Elasticsearch index, see [Elasticsearch support enhancements](./es-enhancements/README.md).

### Citrix ADC Observability Exporter with Kafka as the transaction endpoint

When Kafka is specified as the transaction endpoint, Citrix ADC Observability Exporter converts the transaction data to [Avro](http://avro.apache.org/docs/current/Avro) format and streams them to Kafka.

### Citrix ADC Observability Exporter with Prometheus as the endpoint for time series data

When Prometheus is specified as the format for time series data, Citrix Observability Exporter collects various metrics from Citrix ADCs and converts them to the appropriate Prometheus format and exports them to the Prometheus server. These metrics include counters of the virtual servers, services to which the analytics profile is bound and global counters of HTTP, TCP, and so on.

### Citrix ADC Observability Exporter with Splunk Enterprise as the endpoint for audit logs, events, and transactions 

When Splunk Enterprise is specified as the format for data, Citrix ADC Observability Exporter collects various indexes and audit logs from Citrix ADCs and converts them to appropriate format and exports them to the Splunk Enterprise. Splunk Enterprise captures indexes and correlates real-time data in a repository from which it can generate reports, graphs, dashboards, and visualizations. Splunk Enterprise provides a graphical representation of these data.

## Deployment

You can deploy Citrix ADC Observability Exporter using Kubernetes YAML or Helm charts. To deploy Citrix ADC Observability Exporter using Kubernetes YAML, see [Deployment](https://github.com/citrix/citrix-observability-exporter/blob/master/docs/deploy-coe.md).

## Questions

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
