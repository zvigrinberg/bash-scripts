#!/bin/bash
if [[ $1 == "" ]]
then
  echo "Usage: $0 <ocp_gpu_node_name>"
  echo "Usage: $0 <ocp_gpu_node_name> <OUTPUT_MODE>"
  echo "OUTPUT_MODE=normal|json|jsonlist -> default => normal"
  exit 1
fi

NODE_NAME=$1
OUTPUT_MODE=$2

if [[ $OUTPUT_MODE == "" || $OUTPUT_MODE == "normal"  ]]
then
  OUTPUT_MODE="normal"
elif [[ $OUTPUT_MODE == "json" ]]
then
  OUTPUT_MODE="json"
else
  OUTPUT_MODE="jsonlist"
fi

oc debug node/$NODE_NAME --dry-run=client -o yaml -n default | oc apply -f - --output=yaml | oc label -f - debug=node > /dev/null 2>&1

echo "Show all GPU Replicas Utilization On Node $NODE_NAME"
POD_OF_NODE=$(oc get pod -l=app=nvidia-device-plugin-daemonset -n nvidia-gpu-operator -o json | jq .items[] | jq 'select(.spec.nodeName == "'''$NODE_NAME'''")' |  jq .metadata.name | tr '"' ' ')
if [ -z "${POD_OF_NODE}" ]
then
   POD_OF_NODE=error_pod_not_exists
fi

oc get pods $POD_OF_NODE  -n nvidia-gpu-operator
retVal=$?
if [ $retVal -ne 0 ]
then
  echo $NODE_NAME " is Not a GPU Node, quitting"
   exit $retVal
fi

oc exec -n nvidia-gpu-operator $POD_OF_NODE -c nvidia-device-plugin -- nvidia-smi
echo
echo "Show all Pods On Node $NODE_NAME using the GPU replicas:"
oc exec -n nvidia-gpu-operator $POD_OF_NODE -c nvidia-device-plugin -- nvidia-smi --query-compute-apps=pid,used_memory --format=csv,noheader,nounits > /tmp/pairs.txt
JSON_LIST='['
while read -r line
 do PID=$(echo $line | awk -F "," '{print $1}')
    MEMORY=$( echo $line | awk -F "," '{print $2" Mb"}')
    POD_NAME=$(oc exec $(oc get pod -l debug=node -n default | grep -v NAME | awk '{print $1}') -n default -- nsenter -t $PID -u hostname)
    if [[ $OUTPUT_MODE == "normal" ]]; then
      echo pod_name=$POD_NAME, namespace=$(oc get pods -A | grep $POD_NAME | awk '{print $1}'), memory=$MEMORY, node_host_pid=$PID
      echo
    else
      NAMESPACE=$(oc get pods -A | grep $POD_NAME | awk '{print $1}')
      JSON='{"pod_name": "'''$POD_NAME'''", "namespace": "'''$NAMESPACE'''", "memory": "'''$MEMORY'''", "node_host_pid": "'''$PID'''"}'
      if [[ $OUTPUT_MODE == "jsonlist" ]]; then
        JSON_LIST="${JSON_LIST} ${JSON},"
      else
        echo $JSON | jq .
      fi
    fi
 done < /tmp/pairs.txt
if [[ $OUTPUT_MODE == "jsonlist" ]]; then
  JSON_LIST="${JSON_LIST}]"
  echo $JSON_LIST | sed 's/,]/]/g' | jq .
fi
(oc delete pods -n default -l debug=node > /dev/null 2>&1) &
rm /tmp/pairs.txt
echo
echo "Done!"
echo
exit 0
