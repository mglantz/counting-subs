# counting-subs

Proof of concept for counting JBoss subscriptions. In example script, we use labels to count memory and CPU resources.

To run PoC script:
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
