module.exports = {
  pages: {
    'index': {
      entry: './src/pages/SubmitReport/main.js',
      template: 'public/index.html',
      title: 'Witness Report'
    },
    'arrestee': {
      entry: './src/pages/ArresteeReport/main.js',
      template: 'public/index.html',
      title: 'Arrestee Report'
    },
  },
  outputDir: '../backend/assets/public',
  lintOnSave: 'error',
  devServer: {
    port: 8081,
    proxy: {
      '/api': {
        target: 'http://localhost:1337',
        changeOrigin: true
      }
    }
  }
}
