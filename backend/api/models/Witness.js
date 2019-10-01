module.exports = {
    attributes: {
      witnessEmail: { type: 'string' },
      reports: {
          collection: 'report',
          via: 'witness'
      }
    },
  };