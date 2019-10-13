
exports.up = async function(knex) {
  await knex.raw("ALTER TABLE \"user\" ALTER COLUMN \"expires\" TYPE timestamptz USING to_timestamp(\"expires\")")
  await knex.raw("ALTER TABLE \"user\" ALTER COLUMN \"lastSeenAt\" TYPE timestamptz USING to_timestamp(\"lastSeenAt\")")
};

exports.down = async function(knex) {
  await knex.raw("ALTER TABLE \"user\" ALTER COLUMN \"expires\" TYPE real USING date_part('epoch',\"expires\")::real")
  await knex.raw("ALTER TABLE \"user\" ALTER COLUMN \"lastSeenAt\" TYPE real USING date_part('epoch',\"lastSeenAt\")::real")
};