# Running Kafka cluster locally

The idea is to run a Kafka cluster of many nodes locally without touching the hosts file.
As this does not work in Mac, the workaround is to use a pause container.
This allows all containers to talk to each other using **localhost**.
I updated the example in the below blog post to run many Kafka brokers instead of just one.

For more details check the blog post [Kafka on docker for Mac](https://davidfrancoeur.com/post/kafka-on-docker-for-mac/ "Kafka on docker for Mac")

## How to run

### Run pause container
I tried to add pause container in the compose file as a service and use **network_mode: service:pause_container** , but it did not work, I got the following error. (this change is in one of the commits)

```
$docker-compose up
Creating network "security_default" with the default driver
Creating pause_container ... done
Creating zookeeper1      ... error

ERROR: for zookeeper1  Cannot start service zookeeper1: linux spec namespaces: Invalid IPC mode: service:pause_container

ERROR: for zookeeper1  Cannot start service zookeeper1: linux spec namespaces: Invalid IPC mode: service:pause_container
ERROR: Encountered errors while bringing up the project.
```

Until this issue gets fixed, we need to run the pause container first as following.

```
docker run -d --name pause_container \
    -p 9092:9092 \
    -p 9093:9093 \
    -p 9094:9094 \
    -p 2181:2181 \
    -p 2182:2182 \
    -p 2183:2183 \
    gcr.io/google_containers/pause-amd64:3.0
```

Then, run `docker-compose up`
