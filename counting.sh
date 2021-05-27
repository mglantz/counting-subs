#!/bin/bash
# For JBoss EAP, counts memory and CPU of pods controlled by the JBoss EAP operator

LABEL=$1

totalmem=0
totalcpu=0
for item in $(oc get pods --field-selector status.phase=Running --selector $LABEL --all-namespaces|grep -v NAME|awk '{ print $2 }'); do
	podmemclean=$(oc adm top pods --all-namespaces|grep $item|awk '{ print $4 }'|sed 's/Mi//g')
	podcpuclean=$(oc adm top pods --all-namespaces|grep $item|awk '{ print $3 }'|sed 's/m//g')
	echo "$item consumes MEM: ${podmemclean}Mi and CPU: ${podcpuclean}m"
	totalmem=$(expr $totalmem + $podmemclean)
	totalcpu=$(expr $totalcpu + $podcpuclean)
done

echo "Total memory consumed by labled $LABEL pods: ${totalmem}Mi"
echo "Total CPU consumed by labled $LABEL pods: ${totalcpu}m" 
