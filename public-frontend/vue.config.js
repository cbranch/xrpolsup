module.exports = {
  outputDir: '../backend/assets/public',
  lintOnSave: 'error',
  devServer: {
    port: 8081,
    proxy: {
      '/api': {
        target: 'http://localhost:1337',
        changeOrigin: true,
        pathRewrite: {
          '^/api': ''
        }
      }
    }
  }
}
