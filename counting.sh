#!/bin/bash
# For JBoss EAP, counts memory and CPU of pods controlled by the JBoss EAP operator

totalmem=0
totalcpu=0
for item in $(oc get pods --field-selector status.phase=Running --selector app.kubernetes.io/managed-by=eap-operator --all-namespaces|grep -v NAME|awk '{ print $2 }'); do
	podmem=$(oc adm top pods --all-namespaces|grep $item|awk '{ print $4 }')
	podmemclean=$(oc adm top pods --all-namespaces|grep $item|awk '{ print $4 }'|sed 's/Mi//g')
	podcpu=$(oc adm top pods --all-namespaces|grep $item|awk '{ print $3 }')
	podcpuclean=$(oc adm top pods --all-namespaces|grep $item|awk '{ print $3 }'|sed 's/m//g')
	echo "$item consumes MEM: $podmem and CPU: $podcpu"
	totalmem=$(expr $totalmem + $podmemclean)
	totalcpu=$(expr $totalcpu + $podcpuclean)
done

echo "Total memory consumed by JBoss EAP operator owned pods: ${totalmem}Mi"
echo "Total CPU consumed by JBoss EAP operator owned pods: ${totalcpu}m" 
