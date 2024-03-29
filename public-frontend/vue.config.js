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
    'trial_observation': {
      entry: './src/pages/TrialObservation/main.js',
      template: 'public/trial_observation.html',
      title: 'Trial Observation'
    },
    'plea_hearing': {
      entry: './src/pages/PleaHearing/main.js',
      template: 'public/plea_hearing.html',
      title: 'Plea Hearing'
    },
  },
  outputDir: '../backend/assets/public',
  lintOnSave: 'error',
  devServer: {
    port: 8081,
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
