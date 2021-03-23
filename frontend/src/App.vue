<template>
  <v-app>
    <nav-bar />
    <v-main>
      <router-view />
    </v-main>
    <footer-bar />
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
  components: {
    NavBar: () => import('./components/NavBar.vue'),
    FooterBar: () => import('./components/FooterBar.vue'),
  },
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
}
</script>
