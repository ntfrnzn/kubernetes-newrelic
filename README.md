## Running the New Relic PHP agent in Kubernetes

For more information about all New Relic APM agents see the the core [documentation](https://docs.newrelic.com/docs/agents).


New Relic instrumentation consists of an agent specific to PHP, and a daemon
that collects data from the agent and sends to the New Relic collectors.  The
agent is installed and configured within the application.  In most standard New
Relic deployments the daemon runs as background service on the host.

Because Kubernetes abstracts away the details of infrstructure, there is no reliable
way for the agent to reach a daemon service on the host where it is running.  Yet
the configuration settings of the New Relic PHP agent require that the
daemon be reachable on the same host.

In the configuration here, the daemon runs in a container -- separate from the
application -- but in the same pod.  The daemon listens on a TCP port, and the
agent reaches it at localhost:port-number.

### Docker images

Both the daemon and agent run from the same docker image, but with different
configuration and commands.  The image is based on a stock php-fpm docker image
and adds the New Relic binaries to it.

### Configuration of the daemon

The daemon configuration is stored in the kubernetes cluster as a configmap
and mounted at /etc/newrelic  The listening port number is configured here,
as are various logging details.  The daemon process runs in the foreground
as the only process in the containers

### Configuration of the agent

The agent configuration file is read by php from /usr/local/etc/php/conf.d/  
This directory contains all of the different php .ini files.
Mounting a configmap into that directory would overwrite all of the other files
there.  Instead, the newrelic.ini file pulls values from environment variables
which are defined in the pod spec. The New Relic license key is used by the
agent (not the daemon) and is stored as a secret.

## Deployment

This repository is just some details about how to add New Relic to an actual
application, so all the true deployment details are contingent on application
requirements.  The application will replace the container that is here
named _newrelic-php-agent_  The container named _newrelic-php-daemon_ can be
used unchanged.

The following commands will deploy this configuration into a kubernetes cluster:

```
kubectl create -f newrelic-daemon-configmap.yaml
kubectl create secret generic newrelic-php --from-literal=license_key=${NR_LICENSE}
kubectl create -f newrelic-daemon-deployment.yaml
```
