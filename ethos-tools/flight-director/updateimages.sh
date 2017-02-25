FD_ENDPOINT=$1
curl -X PATCH --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images/listenercpu/listener-cpu -d@listenercpu-fd-imagedefinition.json
curl -X PATCH --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images/distributedcpu/distributed-cpu -d@distributedcpu-fd-imagedefinition.json
curl -X PATCH --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images/stresscpu/stress-cpu-constant -d@cpuload-fd-imagedefinition.json
curl -X PATCH --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images/stressmem/stress-mem-constant -d@memload-fd-imagedefinition.json
curl -X PATCH --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images/stressio/stress-io-constant -d@ioload-fd-imagedefinition.json


