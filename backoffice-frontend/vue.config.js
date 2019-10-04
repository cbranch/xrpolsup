module.exports = {
  outputDir: '../backend/assets/backoffice',
  lintOnSave: 'error',
  devServer: {
    proxy: {
      '/api': {
        target: 'http://localhost:1337',
        changeOrigin: true
      }
    }
  }
}
