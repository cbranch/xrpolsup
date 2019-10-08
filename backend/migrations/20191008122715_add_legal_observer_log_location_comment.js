
exports.up = function(knex, Promise) {
  return knex.schema.table('legalobserverlog', function (table) {
    table.text('location')
    table.text('comment')
  })
};

exports.down = function(knex, Promise) {
  return knex.schema.table('legalobserverlog', function (table) {
    table.dropColumn('location')
    table.dropColumn('comment')
  })
};
