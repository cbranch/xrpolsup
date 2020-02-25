module.exports = {
  datastores: {
    default: {
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
    url: 'redis://localhost:6379/0',
    cookie: {
      secure: true,
      maxAge: 14 * 24 * 60 * 60 * 1000,  // 2 weeks
    },
  },
  sockets: {
    onlyAllowOrigins: [
      'https://arrestwatch.chrisbranch.co.uk',
      'https://backoffice-arrestwatch.chrisbranch.co.uk',
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
