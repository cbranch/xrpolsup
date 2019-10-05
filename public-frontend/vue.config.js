module.exports = {
  pages: {
    'index': {
      entry: './src/pages/WitnessReport/main.js',
      template: 'public/witness.html',
      title: 'Witness Report'
    },
    'pss': {
      entry: './src/pages/ArresteeReport/main.js',
      template: 'public/arrestee.html',
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
