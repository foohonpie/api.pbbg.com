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
      urls: [
        'https://dev.pbbg.com/',
        'https://dev.pbbg.com/about',
      ],
    },
  },
}
