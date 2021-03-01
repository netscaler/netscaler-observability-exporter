# Citrix ADC Observability Exporter troubleshooting

This document explains how to troubleshoot issues that you may encounter while using Citrix ADC Observability Exporter.

-  How do I verify that Citrix ADC sends application data logs to Citrix ADC Observability Exporter?

    Run the following command to verify that Citrix ADC sends application data logs to Citrix ADC Observability Exporter:

        nsconmsg -g lstream_tot_trans_written -d current

    The counter value indicates that the number of application transactions (for example, HTTP transactions) which have been sent to Citrix ADC Observability Exporter.

    If the application traffic rate (for example, HTTP req/sec) that is sent to Citrix ADC Observability Exporter is not equal to `lstream_tot_trans_written`, you can verify the same using the following command:

        nsconmsg -g nslstream_err_ulf_data_not_sendable -d current

    The counter value indicates that Citrix ADC cannot send the data to Citrix ADC Observability Exporter due to network congestion, unavailability of network bandwidth, and so on and the data is stored in the available buffers.

    Information about various transaction data and individual fields, and their datatype are available in the following location on the Citrix ADC:

        shell
        /netscaler/appflow/ns_ipfix.yaml

    To verify the current record type exported from Citrix ADC to Citrix ADC Observability Exporter, use the following command:

        nsconmsg -g appflow_tmpl -d current

    Location of metrics data export logs to Citrix ADC for time series data:

        /var/nslog/metrics_prom.log

    To verify kafka related counters, run the following command:

        kubectl exec -it <cpx-pod-name> [-c <cpx-container-name>] [-n <namespace-name>] -- bash

        tail -f /var/ulflog/counters/lstrmd_counters_codes.log | grep -iE "(http_reqs_done|kafka)"

    Find the logs in the following location to verify that the Citrix ADC Observability Exporter configuration is applied correctly:

        vi /var/logproxy/lstreamd/conf/lstreamd.conf

    If Citrix ADC Observability Exporter fails, you can collect logs available at the following location and contact Citrix Support.

        /cores/ (Loation of coredump files, if any.)
        /var/ulflog/ (Location of `libulfd` logs and counter details.)
        /var/log  (Location of console logs, lstreamd logs and so on.)

For information on Citrix ADC CPX related troubleshooting, see [Citrix ADC CPX Troubleshooting](https://docs.citrix.com/en-us/citrix-adc-cpx/current-release/cpx-troubleshooting.html).