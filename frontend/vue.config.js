const { routes } = require('./src/router/routes.js')

module.exports = {
  lintOnSave: false,

  devServer: {
    disableHostCheck: true,
    progress: false,
  },

  transpileDependencies: [
    'vuetify',
    '@koumoul/vjsf',
  ],

  pluginOptions: {
    sitemap: {
      outputDir: './public',
      baseURL: 'https://dev.pbbg.com',
      routes,
    },
  },
}
