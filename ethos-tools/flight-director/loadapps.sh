#!/bin/bash
#
# Load Booster Load Applications 1-5 into FD database. The NEW_CONTAINER variable needs to altered in order to deployed if you already loaded the applications definitions once already.
#USAGE: 
# ./loadapps.sh <EXTERNAL CONTROL ELB FlightDirector>
# example:
# ./loadapps.sh booster-sandbox-control.clouops.adobe.com
FD_ENDPOINT=$1
NEW_CONTAINER_A="adobecloudops/booster:loadapp-latest"
NEW_CONTAINER_B="adobecloudops/booster:loadgen-latest"
for appdef in cpuload memload distributedcpu listenercpu ioload; 
do
#cpuload image and application defintions
  echo "loading $appdef definitions to flight director."
  curl -X POST --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/applications -d@$appdef-fd-applicationdefinition.json
  curl -X POST --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images -d@$appdef-fd-imagedefinition.json
  echo ""
done

echo "Done loading definitions."
echo ""
#load cpuload enviornment variables
for i in 1 2 3; 
do 
  for appdef in cpuload memload;
  do
    curl -X POST --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/environments -d@$appdef-fd-environment$i.json
  done
done
#load distributed load environment variables
curl -X POST --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/environments -d@distributedcpu-fd-environment1.json
#ioload enviornment variables
curl -X POST --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/environments -d@ioload-fd-environment1.json
curl -X POST --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/environments -d@ioload-fd-environment1.json

echo ""
echo "Altering image to deploy."


#curl -X POST --insecure https://$FD_ENDPOINT/v1/applications/stresscpu/deployments -d imageID=stress-cpu-constant -d newContainerImage=$NEW_CONTAINER_B
echo ""
sleep 3
#curl -X POST --insecure https://$FD_ENDPOINT/v1/applications/distributedcpu/deployments -d imageID=distributed-cpu -d newContainerImage=$NEW_CONTAINER_B
echo ""
sleep 3
#curl -X POST --insecure https://$FD_ENDPOINT/v1/applications/stressmem/deployments -d imageID=stress-mem-constant -d newContainerImage=$NEW_CONTAINER_B
#echo ""
#sleep 3
curl -X POST --insecure https://$FD_ENDPOINT/v1/applications/listenercpu/deployments -d imageID=listener-cpu -d newContainerImage=$NEW_CONTAINER_B
echo ""
sleep 3 
#curl -X POST --insecure https://$FD_ENDPOINT/v1/applications/stressio/deployments -d imageID=stress-io-constant -d newContainerImage=$NEW_CONTAINER_B
echo ""
