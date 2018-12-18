# Ackee MongoDB image with Stackdriver integration

This docker image is designed to be run inside [GKE](https://cloud.google.com/kubernetes-engine/). It is based upon official [Docker Mongo image](https://hub.docker.com/_/mongo/) with Stackdriver agent preinstalled.

## Examples

There are two example deployments in k8s folder :

### Single node

[Single node YAML](k8s/mongo-ackee.yaml) defines just one mongo node, creates user root with password "nicepassword" (using upstream image built-in mechanisms) and set --wiredTigerCacheSizeGB 1 (because if you run Mongo in container it [can't automatically detect](https://docs.mongodb.com/manual/reference/program/mongod/#cmdoption-mongod-wiredtigercachesizegb) right value).
It also creates k8s service named mongo-ackee.

Single node setup uses authentication

### Replica set
[Stateful set YAML](k8s/mongo-statefulset.yaml) uses [cvallance/mongo-k8s-sidecar](https://github.com/cvallance/mongo-k8s-sidecar) project as helper to automatically orchestrate MongoDB replica set in k8s cluster - this example si tightly bound to GCP, because it uses GCE storage class (tho it is only boundary and can be easily changed to any other provider). It also sets up --wiredTigerCacheSizeGB 1 parameter explicitely - same reason as in single node setup. 
This also creates k8s service named mongo-ackee.


Replica set do not use authentication

## Known issues

Intergrated Stackdriver agent uses API to indentify host where the metrics come from, so in Stackdriver UI we do not see container name, but VM instance name, which make it almost impossible to run 2 MongoDB pods on one CGE VM.
