<template>
  <base-layout>
    <v-row class="fill-height">
      <v-col>
        <h1>
          Homepage
        </h1>
        <p>
          PBBG.com is a free online directory of Persistent Browser Based Games, curated and reviewed by the players and developers within the PBBG community.
        </p>
      </v-col>
    </v-row>
  </base-layout>
</template>

<script>
export default {
  name: 'Home',
  components: {
    BaseLayout: () => import('./layouts/BaseLayout.vue'),
  },
  metaInfo: { title: 'PBBG.com' },
}
</script>
