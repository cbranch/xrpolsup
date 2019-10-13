
exports.up = async function(knex) {
  await knex.raw("ALTER TABLE report ALTER COLUMN \"arrestTime\" TYPE timestamptz USING to_timestamp(\"arrestTime\")")
  await knex.raw("ALTER TABLE release ALTER COLUMN \"arrestTime\" TYPE timestamptz USING to_timestamp(\"arrestTime\")")
};

exports.down = async function(knex) {
  await knex.raw("ALTER TABLE report ALTER COLUMN \"arrestTime\" TYPE real USING date_part('epoch',\"arrestTime\")::real")
  await knex.raw("ALTER TABLE release ALTER COLUMN \"arrestTime\" TYPE real USING date_part('epoch',\"arrestTime\")::real")
};