<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        <v-img
          alt="Vuetify Logo"
          class="shrink mr-2"
          contain
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
          transition="scale-transition"
          width="40"
        />

        <v-img
          alt="Vuetify Name"
          class="shrink mt-1 hidden-sm-and-down"
          contain
          min-width="100"
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-name-dark.png"
          width="100"
        />
      </div>

      <v-spacer />

      <v-btn
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
        text
      >
        <span class="mr-2">Latest Release</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
const metaSiteTitle = 'PBBG.com'
const metaSiteTitleDescription = 'Persistent Browser Based Games'
const metaDelimiter = ' | '
const metaSiteDescription = 'PBBG.com is a free online directory of Persistent Browser Based Games, curated and reviewed by the players and developers within the PBBG community.'
const metaSiteBaseUrl = 'https://dev.pbbg.com'
const metaSiteImageUrl = 'https://dev.pbbg.com/pbbgSocialImage.png'
const siteTitleAndTitleDescription = metaSiteTitle + metaDelimiter + metaSiteTitleDescription

export default {
  name: 'App',
  data: () => ({}),
  metaInfo: {
    title: `${metaSiteTitle}`,
    titleTemplate: `${siteTitleAndTitleDescription}`,
    meta: [
      { name: 'description', content: metaSiteDescription },

      // OpenGraph card
      {property: 'og:title', content: siteTitleAndTitleDescription },
      {property: 'og:site_name', content: metaSiteTitle },
      {property: 'og:type', content: 'website'},
      {property: 'og:url', content: metaSiteBaseUrl },
      {property: 'og:image', content: metaSiteImageUrl },
      {property: 'og:description', content: metaSiteDescription },

      // Twitter card
      {name: 'twitter:card', content: 'summary'},
      {name: 'twitter:site', content: metaSiteBaseUrl },
      {name: 'twitter:title', content: siteTitleAndTitleDescription },
      {name: 'twitter:description', content: metaSiteDescription },

      // Google / Schema.org markup:
      {itemprop: 'name', content: siteTitleAndTitleDescription },
      {itemprop: 'description', content: metaSiteDescription },
      {itemprop: 'image', content: metaSiteImageUrl },
    ],
  },
  data: () => ({
    test: 'test',
  }),
}
</script>
