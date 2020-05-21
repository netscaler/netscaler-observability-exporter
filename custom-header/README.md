# Custom header logging

This feature enables logging of all HTTP headers of a transaction. As part of this feature, a new option called `allHttpHeaders` is introduced under the Web Insight analytics profile. When this option is set, Citrix ADC uploads all the request and response headers under `httpAllReqHdrs` and `httpAllResHdrs` respectively. This option is disabled by default. Custom header logging is currently supported only for the Kafka endpoint.

Now, Citrix Observability Exporter transaction records contain two additional fields:

- `httpAllReqHdrs`: This field is a string containing all the request header lines separated by \r\n.
- `httpAllResHdrs`: This field is a string containing all the response header lines separated by \r\n.

## Citrix ADC configuration to enable custom header logging

### Using the Citrix ADC command line

Use the following command from the Citrix ADC command line.

    set analytics profile ns_analytics_default_http_profile -allHttpHeaders  ENABLED

### Using the Citrix ingress controller

To enable `allHttpHeaders` using the Citrix ingress controller, you should set the analytics profile as annotations on the Ingress which is applied on the Citrix ADC.


    ingress.citrix.com/analyticsprofile: '{"webinsight": {"httpurl":"ENABLED", "httpuseragent":"ENABLED", "httphost":"ENABLED", “allhttpheaders”:”ENABLED”, "httpmethod":"ENABLED", "httpcontenttype":"ENABLED"}, "tcpinsight": {"tcpBurstReporting":"DISABLED"}}'

Following is a sample transaction record snapshot:

    {"http_transid": "avro_HTTP_TF_0_c222660a_0_0_T_1577278789_1", "recType": "HTTP_A", "actualtemplatecode": 51, "httpReqMethod": "GET", "httpReqUrl": "/status/500", "httpReqUserAgent": "curl/7.58.0", "httpContentType": "", "httpReqHost": "10.102.34.201", "httpReqAuthorization": "", "httpReqCookie": "", "httpReqReferer": "", "httpResSetCookie": "", "httpAllReqHdrs": "Test: test500get\r\nAccept: */*\r\nHost: 10.102.34.201\r\nUser-Agent: curl/7.58.0\r\n", "httpAllResHdrs": "Connection: keep-alive\r\nContent-Length: 0\r\nContent-Type: text/html; charset=utf-8\r\nDate: Wed, 25 Dec 2019 13:16:39 GMT\r\nServer: gunicorn/19.9.0\r\nAccess-Control-Allow-Origin: *\r\nAccess-Control-Allow-Credentials: true\r\n", "icContGrpName": "", "icFlags": 0, "icNostoreFlags": 0, "icPolicyName": "", "responseMediaType": 0,  