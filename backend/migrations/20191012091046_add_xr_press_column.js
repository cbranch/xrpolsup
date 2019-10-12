
exports.up = function(knex, Promise) {
  return knex.schema.table('release', function (table) {
    table.boolean('canShareWithXRPress')
  })
};

exports.down = function(knex, Promise) {
  return knex.schema.table('release', function (table) {
    table.dropColumn('canShareWithXRPress')
  })
};
