# Support for container logging

Now, you can enable logging on NetScaler Observability Exporter according to different severity levels. These logs help in getting information about endpoint specific configuration.

The following logging severity levels are supported and the default value is `INFO`.

-  `NONE` : None of the messages are logged.
-  `FATAL` : Only fatal messages are logged.
-  `ERROR`:  Only fatal messages and error messages are logged.
-  `INFO`:  Only fatal, error, and informational messages are logged.
-  `DEBUG`: Only fatal, error, informational, and debug messages are logged.

For Kubernetes YAML based deployments the default value is `NONE`. But, for Helm and OpenShift operator deployments of NetScaler Observability Exporter logging is enabled by default and set as `INFO`.

You can configure logging using the environment variable `NSOE_LOG_LEVEL` while deploying NetScaler Observability Exporter for each endpoint.

The following example shows how to configure the log level in the NetScaler Observability Exporter deployment YAML:

         env:
           - name: NSOE_LOG_LEVEL
             value: "INFO"

The following are the types of logs that you can get:

## Error logs

|Log|Severity|Description|
|-|-|-|
|Endpoints Missing - Invalid Config Format| Error| Field "Endpoints" is missing in lstreamd.conf.|
|Splunk Auth Token missing| Error| AuthToken missing for Splunk HEC.|
|Unknown Record Type - Invalid Configuration| Error| Unrecognized record.|
|Record Type Option - Invalid Configuration| Error| Unrecognized argument. Only all/none/anomalous accepted.|
|Unknown Timeseries - Invalid Configuration| Error| Only AUDITLOGS/EVENTS accepted.|
|Setting Rate Limit Enabled to false - Invalid Rate Limit Option - Invalid Configuration| Error| Invalid configuration for rate limiting.|
|Anamalous Config Missing| Error| Anomalous config not found.|
|The configuration file <lstreamd.conf> does not exist|Error|OE tried to read `lstreamd.conf` but did not find it.|
|Either the name of the endpoint or the address of the server is invalid (empty)|Error|The endpoint kind such as SPLUNK,KAFKA,ES,ZIPKIN is empty or its address (ServerUrl) is empty.|
|Invalid value- `<val>` configured Timeseries/`<timeseries-type>` export to No for `<endpoint-type>`|Error| Invalid value for the given type of timeseries (only "yes"/ "no" are allowed)- defaulting to "no".|
|Failed to allocate Packet Engine context for a client|Error|ULFD consumer thread failed to allocate the Packet Engine context (Per NetScaler/ Packet Engine context).|
|Failed to allocate memory to hold the Logstream buffer- perhaps we ran of memory|Error|ULFD consumer thread ran OOM and could not allocate ~ 8 KiB memory required to hold the received Logstream Buffer.|
|Failed to initialize the Processor for the client `<client-id>`|Error|Failed to initialize the Processor for the client.|

## Info logs

|Log|Severity|Description|
|-|-|-|
|lstreamd Process Initiating| Info| NSOE started.|
|lstreamd.conf not found - creating new and switching to agent/ adm on-prem mode| Info| lstreamd.conf was not found.|
|ELK Health Status DOWN| Info| ElasticSearch is down.|
|ELK Health Status UP| Info| ElasticSearch is up.|
|Splunk Health Status DOWN| Info | Splunk is down.|
|Splunk Health Status UP| Info| Splunk is up.|
|Deleting NetScaler IP: `<nsip>` Core: `<core-id>` Partition: `<partition-id>` | Info| Disconnected from a NetScaler.|
|Adding new NetScaler IP: `<nsip>` Core: `<core-id>` Partition: `<partition-id>`| Info| Connected to a new NetScaler.|
|New NetScaler Allocation| Info| Connected to a new NetScaler.|
|New NetScaler Initiating| Info| Connected to a new NetScaler.|
|JSON data format set for KAFKA| Info| JSON will be exported to Kafka.|
|AVRO data format set for Kafka| Info| AVRO will be exported to Kafka.|
|Enabling Traces for Zipkin| Info| Zipkin was configured.|
|Set the maximum number of connections to the endpoint `<type>` as `<maxSockets>`|Info|`MaxConnections` was either parsed or defaulted to the printed value for the printed endpoint.|
|Enabling Kafka Exporter|Info|Kafka was configured in lstreamd.conf and hence enabled.|
|Configured Kafka broker list : `<brokers>`|Info|Applied the configured Kafka Broker list (from the serverUrl).|
|Configured Kafka topic: `<topic>`|Info|KafkaTopic was either parsed or defaulted to the printed value.|
|Configured `<endpoint-type>` to export `<all / anomalous / none> <rec-type>` records|Info|Only the printed records of type `<rec-type: ex HTTP_A/TCP_A/...>` were configured to be exported for the printed endpoint.|
|Configured Timeseries/`<timeseries-type>` to <Yes/No> for `<endpoint-type>`|Info|Auditlogs/Events/Metrics were enabled/disabled for the given endpoint.|
|Configured Processor Yield Timeout to `<val>`|Info|Yield time of the processor threads was either configured or defaulted.|
|Prometheus Mode Enabled- Prometheus can now scrape metrics at the rest port|Info|Prometheus is authorized to perform 'GET /metrics' at the rest port.|
|Received a new client connection|Info|Received a connection from a NetScaler (Packet Engine.)|
|Received a disconnect from a client|Info|Received a disconnect from a NetScaler (Packet Engine).|
|Received a reset from a client|Info|Received a disconnect (reset) from a NetScaler (Packet Engine).|
|JSON transaction rate limiting enabled|Info|Enabled rate-limiting for transactions to JSON-based endpoints viz. Splunk, ElasticSearch, Zipkin, and Kafka (JSON).|
|Set JSON transaction rate limit to `<num>` Logstream buffers per second|Info|Per second rate-limit for logstream buffers.|
|Set JSON transaction Export Queue limit to `<num>` JSON buffers|Info|Limit on the JSON export queue - Beyond this threshold, the Exporter will start dropping JSON buffers.|
|Set JSON transaction rate limit window to `<num>` seconds|Info|Window of rate-limiting transactions to JSON-based endpoints. Lower values can capture spikes.|

## Warning logs

|Log|Severity|Description|
|-|-|-|
|Prometheus Mode Disabled- Prometheus will not be authorized to scrape metrics at the rest port|Warning|Prometheus is unauthorized to perform 'GET /metrics' at the rest port.|

## Debug logs

|Log|Severity|Description|
|-|-|-|
|Spawned Processor #1 with Thread Index: 0 , Thread ID: `<id>`|Debug|Created and started the first processing thread.|
|Spawned ULFD Receiver with Thread Index: 1 , Thread ID: `<id>`|Debug|Created and started the ULFD consumer thread.|
|Spawned Exporter with Thread Index: 2 , Thread ID: `<id>`|Debug|Created and started the export thread.|
|Spawned Processor #2 with Thread Index: 3 , Thread ID: `<id>`|Debug|Created and started the second processing thread.|
|ULFD Receiver received the signal number- `<signo>`|Debug|ULFD consumer thread received a signal (usually from NSULFD) - usually SIGUSR2 is used to induce counter file rotation.|
|ULFD Receiver received timeout event|Debug|ULFD consumer thread received a timeout event (received from NSULFD every second) - used for cleaning up CLM meta records every minute.|
|ULFD Receiver received an unhandleable event - ignoring it|Debug|ULFD consumer thread received an unknown event, thus ignored it.|
|ULFD Receiver received a Logstream Buffer|Debug|ULFD consumer thread received a Data Buffer (Logstream).|
|The received Logstream Buffer is corrupted - unable to parse it|Debug|ULFD consumer thread received a corrupted Data Buffer (Logstream).|
|Parsed the received Logstream Buffer: client-id=<>, core-id=<>, partition-id=<>, namespace=<>|Debug|ULFD consumer thread parsed the received Data Buffer.|
|The rate-limiter decided to drop the Logstream buffer|Debug|Buffer drop because of JSON transaction rate-limiting.|
|The rate-limiter decided to accept the Logstream buffer|Debug|Buffer accepted by JSON transaction rate-limiter.|
|Logstream buffer dropped because the Processor for this client is not emptying the queue fast enough|Debug|Buffer drop because the Processing thread associated with this NetScaler (Packet Engine) is not consuming the buffers fast enough.|
|Logstream buffer dropped because the configuration does not allow accepting Non-Anomalous buffers|Debug|Buffer drop because `Lstreamd` has been configured to process anomalous transactions only.|
|Relinquishing the Logstream buffer because we are done with it|Debug|ULFD consumer thread is done with the received Logstream Buffer- thus relinquishing the shared memory.|
|ULFD Receiver dropped a Logstream buffer- either it was corrupt or we ran out of memory|Debug|ULFD consumer thread dropped the Logstream Buffer because it was corrupt or it ran OOM.|
|Initialized the <AVRO/ JSON> Processor for the client `<client-id>`|Debug|Initialized the printed Processor for the client (done the first time the NetScaler / Packet Engine connects).|
|Pushed `<num-pushed>` Logstream Buffer(s) toward the Processor|Debug|Pushed the printed number of Logstream Buffers to the associated Processing Thread's Queue.|
|Timer fired for the JSON Processor with `thread-id=<thread-id>`, `client-id=<client-id>`|Debug|JSON Processing Thread's Process Timer Timed Out.|
|JSON Processor with thread-id=`<thread-id>`, `client-id=<client-id>` yielded the CPU|Debug|JSON Processing Thread yielded the CPU.|
|JSON Processing Started|Debug|Started converting the Logstream Buffers piled in the queue to JSON.|
|Processing Logstream buffer started|Debug|Started processing a logstream buffer.|
|Dropping a transaction because the JSON Endpoint is not healthy (set "ProcessAlways": "yes" to skip health checks)|Debug|The transaction was dropped because either the JSON endpoint- Splunk/ ElasticSearch was unhealthy or because Kafka (JSON) was not enabled|
|Transaction dropped: Cannot create JSON Object Queue for the Unconfigured Record Type - `<rec-type>`|Debug|The transaction was dropped because it belonged to a Record Type that was not configured (or configured to none).|
|Creating JSON Object Queue for the Record Type - `<rec-type>`|Debug|Created JSON Object Queue for the configured Record Type (used to hold JSON Buffers until they are pushed to the Exporter).|
|Transaction dropped: Cannot create JSON Object Queue for Unknown Protocol ID - `<protocol-id>`|Debug|The transaction was dropped because it belonged to an Unknown Record Type / Protocol ID.|
|Created JSON Object Queue (protocol-id=`<protocol-id>`)|Debug|Created the JSON Object Queue for the printed Record Type / Protocol ID.|
|Set Index to `<index-string>` for the JSON Object Queue|Debug|Set the Index for JSON Object Queue (valid for ElasticSearch/ Splunk endpoints that use indices).|
|Transaction dropped: Unable to create JSON Object Queue- perhaps ran out of memory|Debug|The transaction was dropped because the JSON Object Queue could not be created due to lack of memory.|
|Transaction processing started|Debug|Started the conversion of transaction to JSON.|
|Anomaly: The field is indexed but could not be found in the table- code=`<id>`|Debug|The field is indexed but could not be found in the local meta table.|
|Generated record type-  `<rec-type>` for the transaction|Debug|Generated a JSON record of the printed type for the transaction|
|Transaction processing finished|Debug|Finished the conversion of transaction to JSON.|
|Failed to process the Logstream buffer because the AppFlow codename bearing meta records have not arrived yet from this client|Debug|Dropped the transaction because the Code Maps have not arrived from NetScaler (Packet Engine).|
|Finished processing the Logstream buffer|Debug|Finished processing the logstream buffer.|
|JSON processing finished| Debug| Finished converting the logstream buffers piled in the queue to JSON|
|Pushed the converted JSON transactions to the Processed Queue|Debug|Pushed the converted JSON transactions to the Processed Queue ( common queue where the processed JSONs of all Record Types wait before being handed over to the exporter).|
|Pushed all the piled up JSONs in the Processed Queue to the Exporter|Debug|Handed over all the JSON transactions waiting in the Processed Queue to the Exporter.|
|Started exporting piled up JSON buffers to Kafka Client|Debug|Started the export of the piled up JSON buffers in the export queue to Kafka Client.|
|Finished exporting piled up JSON buffers to Kafka Client|Debug|Finished the export of the piled up JSON buffers in the export queue to Kafka Client.|
|Pushing the JSON buffer back to the Export Queue because of failure in exporting it to the Kafka Client|Debug|Failed to export the JSON buffer to the Kafka client, hence adding it back to the Export Queue.|
|The Exporter dropped `<numDropped>` JSON Buffers because the Export Queue hit its configured limit|Debug|Drop from the Export Queue because of Rate Limiting.|
|Failed to export the JSON Buffer to the Kafka Client because the Kafka Topic Manager has not been created yet|Debug|Could not export JSON Buffer to Kafka Client because the Kafka Topic Manager is not created yet.|
|Created Kafka Topic Manager|Debug|Constructed the Kafka Topic Manager (used to maintain Kafka Client's state).|
|Kafka Topic Manager is creating the topic- `<topic>`|Debug|Kafka Topic Manager is attempting to create the configured topic.|
|Kafka Topic Manager failed to create the topic- perhaps ran out of memory|Debug|Kafka Topic Manager ran OOM thus failed to create the configured topic.|
|Kafka Topic Manager created the the topic|Debug|Kafka Topic Manager created the configured topic|
|Unable to validate the configured topic- failed to acquire a meta connection to the Kafka client, perhaps ran out of memory|Debug|Kafka Topic Manager failed to validate the topic- perhaps ran OOM.|
|Meta Request sent to the Kafka client for topic validation|Debug|Kafka Topic Manager successfully issued Meta Request to the Kafka Client for Topic Validation.|
|Failed to create meta connection to the Kafka Client- perhaps ran out of memory|Debug|Failed to create meta connection to the Kafka Client - perhaps ran OOM.|
|Created meta connection to the Kafka client- connection-id=`<id>`|Debug|Created meta connection to the Kafka Client for the configured topic.|
|Reused existing meta connection to the Kafka Client- connection-id=`<id>`|Debug|Reused existing meta connection to the Kafka Client.|
|Cleaned up the stale meta connection to the Kafka Client- connection-id=`<id>`|Debug|Removed the erroneous meta connection to the Kafka Client from the Meta Connection Pool, for the configured topic.|
|Cleaning up the stale Produce Connection to the Kafka Client- connection-id=`<id>`|Debug|Removed the erroneous produce connection to the Kafka Client from the Produce Connection Pool.|
|Cleaned up the Produce Connection to the Kafka client- connection-id=`<id>`|Debug|Removed a valid produce connection to the Kafka Client from the Produce Connection Pool.|
|Reused existing Produce Connection to the Kafka Client- connection-id=`<id>`| Debug| Reused existing produce connection to the Kafka Client|
|Cleaning up Produce Connections for partition=`<id>`, topic=`<topic>`|Debug|Started the cleanup of produce connections to the Kafka Client.|
|Forcefully cleaned active Produce Connections|Debug|Forcefully cleaned active produce connections to the Kafka Client during partition cleanup.|
|Cleaned inactive Produce Connection|Debug|Cleaned inactive produce connection to the Kafka Client during partition cleanup.|
|Failed to push Kafka Produce Connection to the Stale Connection Pool- unable to find it in the Produce Connection Pool!- connection-id=`<id>`|Debug|Could not find the Kafka Produce Connection in the Kafka Produce Connection Pool.|
|Pushed Kafka Produce Connection to the Stale Connection Pool- connection-id=`<id>`|Debug|Pushed the Kafka Produce Connection to the Kafka Erroneous Connection Queue.|
|Failed to push Kafka produce connection to the Free Connection Pool- unable to find it in the Produce Connection Pool!- connection-id=`<id>`|Debug|Could not find the Kafka Produce Connection in the Kafka Produce Connection Pool.|
|Pushed Kafka Produce Connection to the Free Connection Pool- connection-id=`<id>`|Debug|Pushed the Kafka Produce Connection to the Kafka Erroneous Connection Queue.|
|Cleaned up Produce Connections for the partition|Debug|Cleaned up produce connections for the partition.|
|Begin cleaning up disabled partitions for the topic `<topic>`|Debug|Started cleaning up disabled partitions.|
|Cleaned up disabled partition- id=`<id>`|Debug|Removed the disabled partition from the Disabled Partition Queue.|
|Finished cleaning up disabled partitions|Debug|Finished cleaning up partitions for the topic.|
|Failed to retry failed JSON files to Kafka- the topic state is invalid|Debug|Failed to retry failes JSON files to Kafka because the topic state is not valid.|
|Anomaly: Failed to retry the Kafka JSON File|Debug|Failed to retry failes JSON files to Kafka because of some anomaly.|
|Retried a Kafka JSON File|Debug|Pushed the Kafka JSON file to the Kafka Client for retry.|
|Begin cleaning up the topics|Debug|Started cleaning up the topics (done every 7 seconds).|
|Cleaned up the topic- `<topic>`|Debug|Cleaned up the printed topic.|
|Finished cleaning up the topics|Debug|Finished cleanup up the topics.|
|Failed to export the JSON Buffer to the Kafka Client because the Kafka Topic has not been created yet by the Kafka Topic Manager|Debug|Could not export the JSON Buffer to Kafka Client because the Kafka Topic Manager has not yet created the topic.|
|Pushed the Kafka JSON File to the partition- `<pid>` because the topic is in valid state|Debug|Exported the Kafka JSON file to the Kafka Client.|
|Failed to push the Kafka JSON File to the Kafka Client because the topic is in invalid state|Debug|Could not export the JSON file to the Kafka Client because the topic is in invalid state.|
|Pushed the Kafka JSON Buffer to the partition- `<pid>` because the topic is in valid state|Debug|Exported the Kafka JSON Buffer to the Kafka Client.|
|Failed to push the Kafka JSON Buffer to the Kafka Client because the topic is in invalid state|Debug|Could not export the JSON Buffer to the Kafka Client because the topic is in invalid state.|
|Kafka JSON Buffer death because of failure to send the Produce Request to the Kafka Client- perhaps ran out of memory|Debug|Permanently lost Kafka JSON buffer because of lack of memory.|
|Kafka JSON Buffer death because of lack of Produce Connections- perhaps ran out of memory|Debug|Permanently lost Kafka JSON buffer because of lack of memory.|
|Pushed Kafka JSON Buffer to the Kafka Client|Debug|Exported the Kafka JSON buffer to the Kafka Client.|
|Kafka JSON File death because of failure to send the Produce Request to the Kafka Client- perhaps ran out of memory|Debug|Permanently lost Kafka JSON file because of lack of memory.|
|Kafka JSON File death because of lack of Produce Connections- perhaps ran out of memory|Debug|Permanently lost Kafka JSON file because of lack of memory.|
|Pushed Kafka JSON File to the Kafka Client|Debug|Exported the Kafka JSON file to the Kafka Client.|
|Kafka client rejected the pushed JSON buffer because it was empty|Debug|Kafka Client rejected the pushed JSON buffer because it was empty.|
|Kafka client failed to create a produce request for the pushed JSON buffer- perhaps ran out of memory|Debug|Kafka Client ran OOM while creating the produce request.|
|Kafka client failed to create Kafka File for the pushed JSON buffer- perhaps ran out of memory|Debug|Kafka Client ran OOM while creating the Kafka File.|
|Kafka Client dispatched JSON Buffer to Kafka|Debug|Kafka Client dispatched JSON buffer to Kafka.|
|Kafka client failed to create a produce request for the pushed JSON File- perhaps ran out of memory|Debug|Kafka Client ran OOM while creating the produce request.|
|Kafka Client dispatched JSON File to Kafka|Debug|Kafka Client dispatched JSON File to Kafka.|
|Kafka JSON File death- code=`<errno>`|Debug|Permanently lost kafka file because of the printed error code.|
|Anomaly: The topic this Kafka Connection belongs to does not exist!|Debug|Anomaly: This Kafka Produce connection belonged to an inexistant topic.|
|Anomaly: The partition this Kafka Connection belongs to does not exist!|Debug|Anomaly: This Kafka Produce connection belonged to an inexistant topic.|
|Kafka JSON File death- code=`<errno>`|Debug|Permanently lost kafka file because of the printed error code.|
|Anomaly: The file was sent on an inactive Produce Connection|Debug|Anomaly: The file was sent on an inactive produce connection.|
|Unsuccessful Kafka Produce Request (JSON) - code=`<errno>`|Debug|Unsuccessful Export of Kafka (JSON) File.|
|Anomaly: Kafka Topic Died- JSON File death|Debug|Anomaly: Kafka Topic Died- JSON File death.|
|Successful Kafka Produce Request- JSON File uploaded|Debug|Uploaded JSON File to Kafka.|
|Death of Kafka JSON File during retry- the configured retry rate is 0!|Debug|Dropped the new JSON File because KafkaRetryRate is 0.|
|Death of old Kafka JSON File during retry- Retry Queue limit reached|Debug|Dropped the old JSON File because the Retry Queue was full (upto 32K files are stored).|
|Pushed new Kafka JSON File to Retry Queue|Debug|Pushed new Kafka JSON File to Retry Queue.|
|Kafka Client failed to create Topic Metadata Request- perhaps ran out of memory|Debug|Kafka client ran OOM.|
|Kafka Client dispatched Topic Metadata Request to Kafka|Debug|Kafka Client dispatched Topic Metadata Request to Kafka.|
|Failed to create Produce Connection to the Kafka Client- perhaps ran out of memory|Debug|Kafka client ran OOM.|
|Created Produce Connection to the Kafka Client- connection-id=`<id>`|Debug|Kafka client successfuly created Produce Connection.|
|Anomaly: The topic this Kafka Meta Connection belongs to does not exist!|Debug|Anomaly: This Kafka Meta connection belonged to an inexistant topic.|
|Invalid Topic Metadata response received from Kafka- code=`<errno>`, empty=<true/false>, status=<sent/not sent>|Debug|Topic state invalidated.|
|The Topic Metadata response received from Kafka bore no topics|Debug|Topic state invalidated.|
|Kafka Client failed to create the partition- `<id>` for the topic- `<topic>`, perhaps ran out of memory|Debug|Kafka client ran OOM|
|Kafka Client created  partition with leader=`<leader>`, partition-id=`<id>`, topic=`<topic>` : topic state is now validated|Debug|Kafka client created a partition.|
|Kafka Client failed to find a valid partition for the topic- `<topic>` invalidating the topic state|Debug|Kafka client failed to find a suitable partition for the topic- thus invalidated its state.|
|Rare condition: recreating a partition with active Produce Connections to the Kafka client- disabling the older partition and creating a new one- partition-id=`<id>`, topic=`<topic>`|Debug|The leader of a partition changed while a produce connection was actively pushing a file to that partition on Kafka- thus disabling the partition and creating a new one in its place.|
|Kafka Client recreated  partition with leader=`<leader>`, partition-id=`<id>`, topic=`<topic>` : topic state is now validated|Debug|Kafka client recreated a partition.|
|Kafka Client setting partition- `<id>` as leaderless, topic=`<topic>`|Debug|Found no leader for the printed topic partition.|
|Kafka Client setting partition- `<id>` as having leader, topic=`<topic>`|Debug|Found leader for the printed topic partition.|
|No leader exists for any partition of the topic- `<topic>`, invalidating its state|Debug|Found no leader for the configured topic- invalidating its state.|
|Kafka Client received a valid Topic Metadata Response from Kafka- topic `<topic>` has been validated|Debug|Topic state validated.|
|Received a Non-POST request for auditlogs-- only POST is supported, dropping it|Debug|Received a Non-POST request for auditlogs -- only POST is supported for this URL, dropping it.|
|x-appflow-id header not present in the auditlog POST request -- dropping it|Debug|x-appflow-id header not present in the POST request for auditlogs -- dropping it.|
|The requestor is not authorized to POST auditlogs -- dropping it|Debug|The requestor is not authorized to POST auditlogs -- dropping it.|
|Received Auditlog request|Debug|Received Auditlog request.|
|Received a Non-Post request for events -- only POST is supported, dropping it|Debug|Received a Non-Post request for events -- only POST is supported for this URL, dropping it.|
|x-appflow-id header not present in the event POST request -- dropping it|Debug|x-appflow-id header not present in the POST request for events -- dropping it.|
|The requestor is not authorized to POST events -- dropping it|Debug|The requestor is not authorized to POST events -- dropping it.|
|Received Event Request|Debug|Received Event Request.|
|Death of empty auditlog/event buffer|Debug|Empty buffers are not exported.|
|Death of  event/ auditlog buffer because of lack of memory|Debug|Ran OOM.|
|Processed an event/ auditlog|Debug|Processed an Event/ Auditlog.|
|Death of an obese event/ auditlog|Debug|One single Auditlog/ Event was too large (exceeded 32 KiB).|
|Death of event/auditlog buffer due to JSON parsing error|Debug|Death of event/auditlog buffer due to JSON parsing error.|
|Death of `<num>` events/auditlogs during processing|Debug|Some auditlogs/ events dies during processing.|
|Pushed `<num>` event/auditlog JSON buffers to the Export Queue|Debug|Pushed some events/ auditlogs to the Export Queue.|
