module.exports = {
    attributes: {
      station: { type: 'string' },
      arrestTime: {
        type: 'ref',
        columnType: 'timestamp',
        required: true,
      },
      location: { type: 'string', required: true },
      name: { type: 'string' },
      arrestingOfficerId: { type: 'string' },
      concernMentalDistress: { type: 'boolean', defaultsTo: false },
      concernPhysicalDistress: { type: 'boolean', defaultsTo: false },
      concernMinor: { type: 'boolean', defaultsTo: false },
      concernPoliceBehaviour: { type: 'boolean', defaultsTo: false },
      concernPolicePrejudice: { type: 'boolean', defaultsTo: false },
      concernMedicationNeed: { type: 'boolean', defaultsTo: false },
      medicationName: { type: 'string' },
      observations: { type: 'string' },
      comment: { type: 'string' },
      witness: { model: 'witness' },
      isHidden: { type: 'boolean', defaultsTo: false },
    },
  };