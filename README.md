# Entitlements in Real-Time

This repository is the accompanying proof-of-concept implementation to the "Entitlements in
Real-Time" blog post located [here](https://www.experoinc.com/post/graph-based-rbac-using-streaming-synchronization).

There is a `docker-compose` file for getting up and running with MariaDB, a
Confluent cluster, and a TigerGraph instance. Note the POC used a `m5a.4xlarge`
EC2 instance to run all the docker services. You may be able to use something
smaller though.

## Instructions

1. Run all the containers up with `docker-compose up -d`
2. Run the database schema create SQL in LDAP.sql in PhpMyAdmin (`localhost:3307`) or some other interface.
3. Create the JDBC Source Connectors in Control Center (`localhost:9021`) or through the REST API.
Images for Control Center are located in the `images` folder, and the JSON configs are located in the
`kafka-connect` folder.
4. Create the topics as well (`ldap-roles`, `ldap-parties`, `ldap-party_roles`).
5. Enter into the `tigergraph` container.
6. Run `gadmin start`. This starts up TigerGraph.
7. Run `gsql /home/tigergraph/entitlements.gsql`. This creates the schema and loading jobs.
8. Run `gsql` to enter the GSQL console.

```
> USE GRAPH Entitlements
> RUN LOADING JOB load_resources
> RUN LOADING JOB real_time_loader
```

`real_time_loader` will continue to run in the foreground of the GSQL shell

9. Run the SQL inserts
10. Open up GraphStudio at `localhost:14240` and navigate through your graph.
11. Run the SQL updates and reload GraphStudio to make sure it caught the updates to the graph.
