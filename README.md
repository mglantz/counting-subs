# counting-subs

Proof of concept for counting JBoss subscriptions. In example script, we use labels to count memory and CPU resources.
If you want to count resources for all running pods managed by the JBoss EAP operator, use:

```
app.kubernetes.io/managed-by=eap-operator
```
