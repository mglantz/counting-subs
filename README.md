<h1>Counting subs</h1>
Proof of concept for counting JBoss subscriptions. In example script, we use labels to count memory and CPU resources.
If you want to count resources for all running pods managed by the JBoss EAP operator, use:

```
app.kubernetes.io/managed-by=eap-operator
```
So theoretically there are 2 options to count the memory & cpu consumptions for specific pods:

<h3>1 - Leveraging Meta Information</h3>
    For example by using: specific labels or annotations like the example above. The count can be done on demand via Ansible, scripts or regular CLI. Alternatively it can be done with a specific prometheus command (tbd - base: rate(container_cpu_usage_seconds_total[5m])). E.g. with the script you can in combination with the EAP operator count pod utilization with the "managed by" label mentioned above, the pods also have an annotation that can be leveraged:    
    
```  
wildfly.org/server-type: generic   
```

<h3>2 - Leveraging the image</h3>
    For example by identifing the specific image and counting the instances of that. 
    
Both scenarios have downsides: e.g. Labels can be forgotten or modified, imagines only work if its clear which are to be counted. Leveraging the base image only works if all use the base image. The most fool proof scenario is actually a third that leverages either one (or both) of the above:

<h3>3 - leveraging registry scanning.</h3>
    So in the case of JBoss subscriptions, it is possible use container scanners to detect which images are using JBoss binaries, then choose to use either approach 1 or 2.


<h2>To run PoC script:</h2>

```
wget https://raw.githubusercontent.com/mglantz/counting-subs/main/counting.sh
sh ./counting.sh label=value
```

Example. If you want to count resources for all running pods managed by the JBoss EAP operator:

```
sh ./counting.sh app.kubernetes.io/managed-by=eap-operator
```

Example output:

```
$ sh ./countnew app.kubernetes.io/managed-by=eap-operator
operator-example-0 consumes MEM: 819Mi and CPU: 29m
operator-example-1 consumes MEM: 821Mi and CPU: 21m
Total memory consumed by labled app.kubernetes.io/managed-by=eap-operator pods: 1640Mi
Total CPU consumed by labled app.kubernetes.io/managed-by=eap-operator pods: 50m
```




