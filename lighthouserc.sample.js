module.exports = {
  ci: {
    collect: {
      numberOfRuns: 1,
      url: ['https://example.com/'],
    },
    upload: {
      target: 'lhci',
      serverBaseUrl: 'https://lighthouse-ci-server',
      token: 'xxxxxxxxxxxxxxxxxxxx'
    }
  }
}
