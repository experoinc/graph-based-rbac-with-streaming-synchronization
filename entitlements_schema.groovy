system.graph("entitlements").ifNotExists().create()

schema.propertyKey("party_id").Int().ifNotExists().create()
schema.propertyKey("full_name").Text().ifNotExists().create()
schema.propertyKey("email").Text().ifNotExists().create()

schema.propertyKey("identity_id").Int().ifNotExists().create()
schema.propertyKey("name").Text().ifNotExists().create()

schema.propertyKey("created_at").Text().ifNotExists().create()
schema.propertyKey("updated_at").Text().ifNotExists().create()

schema.vertexLabel("party").partitionKey("party_id").properties("full_name", "email", "created_at", "updated_at").create()
schema.vertexLabel("identity").partitionKey("identity_id").properties("name", "created_at").ifNotExists().create()

schema.edgeLabel("is_a").properties("created_at").connection("party", "identity").ifNotExists().create()
