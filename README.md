# Entitlements in Real-Time

This repository is the accompanying proof-of-concept to the "Entitlements in
Real-Time" blog post located here.

There is a `docker-compose` file for getting up and running with a relational
database, a Confluent cluster, and a DataStax Enterprise node.

## Instructions

1. Run all the containers up

  ```bash
  docker-compose up -d
  ```

2. Install JDK 8 into the dse container to work around an issue in this docker image version

  ```bash
  docker exec -u 0 -it dse bash
  apt install openjdk-8-jdk
  ```

3. While in the dse container, run the groovy script to create the schema.
4. Go into the connect container

  ```bash
  docker exec -it connect bash
  cd /usr/shar/java
  wget https://downloads.datastax.com/labs/kafka-connect-dse.tar.gz
  tar -xvf kafka-connect-dse.tar.gz
  rm -f kafka-connect-dse.tar.gz
  cd kafka-connect-jdbc
  wget https://downloads.mariadb.com/Connectors/java/connector-java-2.4.4/mariadb-java-client-2.4.4.jar
  ```

5. Restart the container
6. Navigate to `localhost:9021` (Control Center) and create a
JdbcSourceConnector according to `images/jdbc-source.png`
7. Create a DseSinkConnector according to `images/dse-sink.png`
8. Create 3 topics in your Kafka cluster called `ldap-parties`,
`ldap-entities`, `ldap-party_entities`. These are of the form
`{topic-prefix-}{table-name}`

Here is where things get tricky. At this point in the development of the
cluster, you should be able to see data stream through your topics as data is
getting inserted into your tables. The `DseSinkConnector` in its current state
seems to be missing configuration options for directing Kafka records to
Cassandra keyspaces/tables. In a perfect world, you would setup 3 DSE sinks
using the 3 Kafka topics you created, and map/direct data accordingly, which
would then be viewable at both the Cassandra and graph levels within DSE.

With the information in this repo and the blog, you could easily switch out DSE
for some other data stora whether it be graph, relational, or NoSQL.

The last parts of the blog post will cover a potential in-the works" solution.
