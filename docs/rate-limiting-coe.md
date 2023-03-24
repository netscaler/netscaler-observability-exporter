# Rate limiting support

If you are experiencing high memory usage issues with Citrix ADC Observability Exporter, you can enable rate limiting support for transactions in ElasticSearch, Splunk, and Zipkin endpoints.

The following parameters are added for the rate-limiting support.

| Parameter | Default value | Description|
|---------|-----------------|-------------------- |
| `transRateLimitEnabled` (Optional)|  `no`   | Set this value as `yes` to enable rate limiting for transactions. |
| `transRateLimit` (Optional) | 1 | Specifies the rate-limit in terms of log stream buffers per second. Here, a limit of 100 means 100 log buffers per second. Each log buffer is 8 kibibyte (KiB) in size. That means Citrix ADC Observability Exporter receives about 800 KiB per second. This value translates to approximately 800 TPS. But 800 TPS is an approximation and the size can vary to more or less than 800 TPS.  |
| `transQueueLimit` (Optional) | 1024 | Specifies the number of JSON buffers that can pile up, before Citrix ADC Observability Exporter starts discarding them. For Zipkin, one JSON buffer is about 64 KiB and a limit of 1000 means approximately 64 MB of JSON data. For Splunk and ElasticSearch, one JSON buffer is about 32 KiB and a limit of 1000 means approximately 32 MB of data.|
|  `transRateLimitWindow` (Optional) | 5 |Specifies the recalculation window in seconds and the value must be greater than zero. The lower the window size, the more effective is the rate-limiting. But, the lower value can cause CPU overhead.|

To resolve memory usage issues, you can set the `transRateLimitEnabled` option as `yes` and the `transRateLimit` to 100 (customizable). You can try varying the `transRateLimit` value and find out the value that works best for your environment.

> **Note:**
> Your records may get dropped if they are being exported at a rate higher than the configured `transRateLimit`.

The following is a sample JSON configuration for Splunk with rate limiting options enabled.

      {
        "transRateLimitEnabled": "yes",
        "transRateLimit": "100",
        "transQueueLimit": "1024",
        "transRateLimitWindow": "5",
        "Endpoints": {
              "SPLUNK": {
                "ServerUrl": "<server-url>",
                "AuthToken": "<auth-token>",
                "Index": "",
                "RecordType": {
                  "HTTP": "all",
                  "TCP": "all",
                  "SWG": "all",
                  "VPN": "all",
                  "NGS": "all",
                  "ICA": "all",
                  "APPFW": "all",
                  "BOT": "all",
                  "VIDEOOPT": "all",
                  "BURST_CQA": "all",
                  "SLA": "all",
                  "MONGO": "all"
                },
                "TimeSeries": {
                  "EVENTS": "yes",
                  "AUDITLOGS": "yes"
                },
                "ProcessAlways": "yes",
                "ProcessYieldTimeOut": "500",
                "MaxConnections": "512",
                "JsonFileDump": "no"
              }
            }
      }
