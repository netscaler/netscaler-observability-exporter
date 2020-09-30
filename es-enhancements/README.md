
# Elasticsearch support enhancements

This topic provides information about the Elasticsearch enhancements
introduced in the Citrix Observability Exporter release 1.2.001.

## Support of fields in string format

Effective with the Citrix Observability Exporter release 1.2.001, when the Citrix Observability Exporter sends the data to the Elasticsearch server some of the fields are available in the string format.

The following fields are available in the string format:

- `transCltIpv4Address`	
- `transCltDstIpv4Address`
- `backendSvrIpv4Address`
- `backendSvrDstIpv4Address`
- `observationPointId`
- `reqTimestamp`
- `httpTransEndTime`
- `sslFLagsFE`
- `sslFLagsBE`
- `sslSrvrCertSigHashFE`
- `sslSrvrCertSigHashBE`
- `sslClntCertSigHashFE`
- `sslClntCertSigHashBE`
- `sslHandshakeErrorMsg`
- `tcpClntConnRstCode`
- `tcpSrvrConnRstCode`

## Support for index configuration

Now, you can configure the following options for the Elasticsearch index for scalability and flexibility.

- `IndexPrefix`: Specifies the value which is used as a prefix to the index string. The default value is set as `adc_coe`.

- `IndexInterval`: Specifies the interval for creating the Elasticsearch index. The following interval values can be specified for creating the Elasticsearch index:

  - `hourly` 
  - `12hours`
  - `daily`
  - `weekly`
  - `2weeks`
  - `monthly`
  - `6months`
  - `yearly`

Following is a snippet of an example configuration of `IndexPrefix` and `IndexInterval`.

    "IndexPrefix": "adc_coe"
    "IndexInterval": "hourly"

Following example shows an index created on Sep 30 11:42:34 UTC 2020.

    adc_coe_h11_d30_m9_y2020
