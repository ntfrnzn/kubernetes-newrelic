## New Relic Server Monitoring Agent Example

This example shows how to run a New Relic server monitoring agent as a pod in a DaemonSet on an existing Kubernetes cluster.

This example will create a DaemonSet which places the New Relic monitoring agent on every node in the cluster. It's also fairly trivial to exclude specific Kubernetes nodes from the DaemonSet to just monitor specific servers.

### Step 0: Prerequisites

This process will create privileged containers which have full access to the host system for logging. Beware of the security implications of this.


### Step 1: Configure New Relic Agent

The New Relic agent is configured via environment variables, which are deployed in kubernetes secret

The script, `create-secret.sh` uses kubectl to construct the secret.  Modify this as necessary to
insert your New Relic license key.

### Step 2: Deploy the agent DaemonSet

```
kubectl --namespace=kube-system create -f newrelic-daemonset.yaml
```
