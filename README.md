# Druid cluster

## Basic Druid cluster elements

[Install Docker](docker-install.md)


O que é o Druid?

O druid é uma composição dos seguintes componentes:

- [Historical](http://druid.io/docs/latest/design/historical.html) nodes are the workhorses that handle storage and querying on "historical" data (non-realtime). Historical nodes download segments from deep storage, respond to the queries from broker nodes about these segments, and return results to the broker nodes. They announce themselves and the segments they are serving in Zookeeper, and also use Zookeeper to monitor for signals to load or drop new segments.

- [Coordinator](http://druid.io/docs/latest/design/coordinator.html) nodes monitor the grouping of historical nodes to ensure that data is available, replicated and in a generally "optimal" configuration. They do this by reading segment metadata information from metadata storage to determine what segments should be loaded in the cluster, using Zookeeper to determine what Historical nodes exist, and creating Zookeeper entries to tell Historical nodes to load and drop new segments.
- [Broker](http://druid.io/docs/latest/design/broker.html) nodes receive queries from external clients and forward those queries to Realtime and Historical nodes. When Broker nodes receive results, they merge these results and return them to the caller. For knowing topology, Broker nodes use Zookeeper to determine what Realtime and Historical nodes exist.
- [Indexing Service](http://druid.io/docs/latest/design/indexing-service.html) nodes form a cluster of workers to load batch and real-time data into the system as well as allow for alterations to the data stored in the system.
- [Realtime](http://druid.io/docs/latest/design/realtime.html) Realtime nodes also load real-time data into the system. They are simpler to set up than the indexing service, at the cost of several limitations for production use.



![flow-part-1](http://druid.io/docs/img/druid-dataflow-3.png)

![flow-part-2](http://druid.io/docs/img/druid-manage-1.png)



Download and launch the docker image

```sh
docker compose up
```

Wait a minute or so for Druid to start up and download the sample.

On OS X

- List datasources

```
curl http://$(docker-machine ip default):3000/druid/v2/datasources
```

- access the coordinator console

```
open http://$(docker-machine ip default):3001/
```

On Linux

- List datasources

```
curl http://localhost:3000/druid/v2/datasources
```

- access the coordinator console at http://localhost:3001/

## Build Druid Docker Image

To build the docker image yourself

```sh
git clone https://github.com/druid-io/docker-druid.git
docker build -t example-cluster docker-druid
```
