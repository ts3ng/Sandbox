

function usage {
    echo "usage: $0 [options]"
    echo "       -t|--task                      delete/update/list"
    echo "       -a|--application-id            Flight Director Application ID"
    echo "       -i|--image-id                  Flight Director Image ID"
    echo "       -f|--flight-director-url       Flight Director URL"
    echo "       -j|--json-image             image definition file"
    echo "       -h|--help                      Show this message"
    echo "ENTER INTERACTIVE MODE"
    echo "./fd.sh"
    echo ""
    echo "example: RESTART"
    echo "./fd.sh -t RESTART -a listenercpu -i listener-cpu -f booster-s-external-1nnr990524o4e-1010747746.us-east-1.elb.amazonaws.com -j listenercpu-fd-imagedefinition.json"
    echo "example: DELETE"
    echo ""
    echo "example: LIST"
    echo ""
    echo "example: UPDATE"
    echo "./fd.sh -t UPDATE -a listenercpu -i listener-cpu -f booster-s-external-1nnr990524o4e-1010747746.us-east-1.elb.amazonaws.com -j listenercpu-fd-imagedefinition.json"
    echo "example: DEPLOY"
    echo "./fd.sh -t DEPLOY -f booster-s-external-1nnr990524o4e-1010747746.us-east-1.elb.amazonaws.com -a listenercpu -i listener-cpu -d adobecloudops/booster:loadapp-latest"
    exit 1
}

if [[ "$1" == '--help' || "$1" == '-h' ]]; then
  usage
fi

if [[ $# -eq 0 ]]; then
  # Interactive mode.
  echo "Entering interactive mode. For CLI mode options, use --help."

  echo "Task to execute <DELETE|UPDATE|LIST|RESTART|LIST-IMAGE|GET-IMAGES>"
  read TASK

  echo "Flight Director Application ID "
  read APPID

  echo "Flight Director Image ID"
  read IMAGEID
  
  echo "Flight Directory URL"
  read FD_ENDPOINT
    
  echo "Flight Directory URL"
  read JSON_IMAGE
else
  while [[ $# > 1 ]]
  do
  key="$1"

  case $key in
      -t|--task)
      TASK=$2
      shift;;
      -a|--app-id)
      APPID=$2
      shift;;
      -i|--image-id)
      IMAGEID=$2
      shift;;
      -f|--flight-director-url)
      FD_ENDPOINT=$2
      shift;;
      -j|--json-image)
      JSON_IMAGE=$2
      shift;;
      -d|--docker-tag)
      DOCKER_TAG=$2
      shift;;
      *)
              # unknown option
      ;;
  esac
  shift # past argument or value
  done
fi

if [[ "$TASK" == "DELETE" ]]; then
  echo "Delete Application $APPID"
  curl -X DELETE --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v1/applications/$APPID/$IMAGEID 
elif [[ "$TASK" == "UPDATE" ]]; then
  echo "Update Image $IMAGEID"
  curl -v -X PATCH --insecure -H "Content-Type: application/json" https://$FD_ENDPOINT/v2/images/$APPID/$IMAGEID -d@$JSON_IMAGE
elif [[ "$TASK" == "DEPLOY" ]]; then
  echo "Deploying Application $APPID/$IMAGEID newcontainerImage $DOCKER_TAG"
  curl -v -X POST --insecure https://$FD_ENDPOINT/v1/applications/$APPID/deployments -d imageID=$IMAGEID -d newContainerImage=$DOCKER_TAG
elif [[ "TASK" == "RESTART" ]]; then
  echo "Restart ApplicationID: $APPID ImageID: $IMAGEID"
  echo RESTART.json | sed "s/{{IMAGE}}/$IMAGEID/g" | sed "s/{{APP}}/$APPID/g" > RESTART_TEMP.json
  curl -v -X POST --insecure https://$FD_ENDPOINT/v2/deployments -d@RESTART_TEMP.json
elif [[ "$TASK" == "LIST-IMAGE" ]]; then
  echo "Image Definition"
  curl -v -X GET --insecure https://$FD_ENDPOINT/v2/images/$APPID/$IMAGEID | jq "."
elif [[ "$TASK" == "GET-IMAGES" ]]; then
  curl -x -X GET --insecure http://$FD_ENDPOINT/v2/images | jq '.data | select(.type="image-definition")'
fi




