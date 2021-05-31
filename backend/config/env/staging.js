const BASE_HOSTNAME = process.env.BASE_HOSTNAME || "arrestwatch.info"

module.exports = {
  datastores: {
    default: {
      adapter: "sails-postgresql",
      url: "postgresql://postgres:hunter12@db:5432/postgres",
    },
  },
  models: {
    migrate: 'safe',
  },
  blueprints: {
    shortcuts: false,
  },
  security: {
    cors: {
    },
  },
  session: {
    adapter: '@sailshq/connect-redis',
    url: 'redis://redis:6379/0',
    cookie: {
      secure: false,
      maxAge: 14 * 24 * 60 * 60 * 1000,  // 2 weeks
    },
  },
  sockets: {
    onlyAllowOrigins: [
      'https://' + BASE_HOSTNAME,
      'https://backoffice.' + BASE_HOSTNAME,
      'http://' + BASE_HOSTNAME,
      'http://backoffice.' + BASE_HOSTNAME,
    ],
  },
  log: {
    level: 'debug'
  },
  http: {
    cache: 24 * 60 * 60 * 1000, // One day
    trustProxy: true,
  },
  port: 8080,
  custom: {
  },
};
