
exports.up = function(knex, Promise) {
  return knex.schema.table('report', function (table) {
    table.boolean('concernHandcuffs')
  })
};

exports.down = function(knex, Promise) {
  return knex.schema.table('report', function (table) {
    table.dropColumn('concernHandcuffs')
  })
};
