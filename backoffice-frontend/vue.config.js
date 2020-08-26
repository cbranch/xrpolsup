module.exports = {
  pages: {
    'index': {
      entry: './src/main.js',
      template: 'public/index.html',
      title: 'XR Arrestee Support'
    },
    'killswitch': {
      entry: './src/pages/KillSwitch/main.js',
      template: 'public/index.html',
      title: 'Kill switch'
    },
  },
  outputDir: '../backend/assets/backoffice',
  lintOnSave: 'error',
  devServer: {
    proxy: {
      '/api/v1': {
        target: 'http://localhost:1337',
        changeOrigin: true
      },
      '/api/v2': {
        target: 'http://localhost:8000',
        changeOrigin: true
      },
      '/ws/': {
        target: 'http://localhost:8000',
        changeOrigin: true
      }
    }
  }
}
