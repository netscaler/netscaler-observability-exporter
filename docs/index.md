# Citrix Observability Exporter

 Citrix Observability Exporter is a container which collects metrics and transactions from Citrix ADCs and transforms them to suitable formats (such as JSON, AVRO) for [supported endpoints](#Supported-Endpoints). You can export the data collected by Citrix Observability Exporter to the desired endpoint. By analyzing the data exported to the endpoint, you can get valuable insights at a microservices level for applications proxied by Citrix ADCs.

## Supported Endpoints

 Citrix Observability Exporter currently supports the following endpoints:

 - [Zipkin](https://zipkin.io/)
 - [Kafka](https://kafka.apache.org/)
 - [Elasticsearch](https://www.elastic.co/products/elasticsearch)

## Overview

### Distributed tracing support with Zipkin

In a microservice architecture, a single end-user request may span across multiple microservices and tracking a transaction and fixing sources of errors is challenging. In such cases, traditional ways for performance monitoring cannot accurately pinpoint where failures occur and what is the reason behind poor performance. You need a way to capture data points specific to each microservice which is handling a request and analyze them to get meaningful insights.

Distributed tracing addresses this challenge by providing a way to track a transaction end-to-end and understand how it is being handled across multiple microservices. [OpenTracing](https://opentracing.io/) is a specification and standard set of APIs for designing and implementing distributed tracing. Distributed tracers allow you to visualize the data flow between your microservices and helps to identify the bottlenecks in your microservices architecture.

Citrix Observability Exporter implements distributed tracing for Citrix ADC and currently supports [Zipkin](https://zipkin.io/) as the distributed tracer.

Currently, you can monitor performance at the application level using Citrix ADC. Using Citrix Observability Exporter with Citrix ADC, you can get tracing data for microservices of each application proxied by your Citrix ADC CPX, MPX, or VPX.

### Transaction collection and streaming support

Citrix Observability Exporter supports collecting transactions and streaming them to endpoints. Currently, Citrix Observability Exporter supports Elasticsearch and Kafka as transaction endpoints.

## How does Citrix Observability Exporter work

### Distributed tracing with Zipkin using Citrix Observability Exporter

Logstream is a Citrix-owned protocol that is used as one of the transport modes to efficiently transfer transactions from Citrix ADC instances. Citrix Observability Exporter collects tracing data as Logstream records from multiple Citrix ADCs and aggregates them. Citrix Observability Exporter converts the data into a format understood by the tracer and then uploads to the tracer (Zipkin in this case). For Zipkin, the data is converted into JSON, with Zipkin-specific key values.

You can view the traces using Zipkin user interface. However, you can also enhance the trace analysis by using [Elasticsearch](https://www.elastic.co/products/elasticsearch) and [Kibana](https://www.elastic.co/products/kibana) with Zipkin. Elasticsearch provides long-term retention of the trace data and Kibana allows you to get much deeper insight into the data.

### Citrix Observability Exporter with Elasticsearch as the transaction endpoint

When Elasticsearch is specified as the transaction endpoint, Citrix Observability Exporter converts the data to JSON format. On the Elasticsearch server, Citrix Observability Exporter creates Elasticsearch indexes for each ADC on an hourly basis. These indexes are based on data, hour, UUID of the ADC, and the type of HTTP data (http_event or http_error). Then, Citrix Observability Exporter uploads the data in JSON format under Elastic search indexes for each ADC. All regular transactions are placed into the http_event index and any anomalies are placed into the http_error index.  

### Citrix Observability Exporter with Kafka as the transaction endpoint

When Kafka is specified as the transaction endpoint, Citrix Observability Exporter converts the transaction data to [Avro](http://avro.apache.org/docs/current/Avro) format and streams them to Kafka.

## Deployment

You can deploy Citrix Observability Exporter using Kubernetes YAML. To deploy Citrix Observability Exporter using Kubernetes YAML, see [Deployment](deploy-coe.md).

