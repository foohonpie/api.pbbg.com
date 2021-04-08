<template>
  <v-footer
    padless
    dark
  >
    <v-card
      class="text-center secondary"
      width="100%"
      flat
      tile
    >
      <v-card-text>
        <v-btn
          v-for="icon in icons"
          :key="icon"
          icon
        >
          <v-icon>
            {{ icon }}
          </v-icon>
        </v-btn>
      </v-card-text>

      <v-card-text class="white--text pt-0">
        Persistent Browser Based Games, the players who love them, and the developers who create them.
      </v-card-text>

      <v-divider />

      <v-card-text class="white--text">
        2021 — <strong>Foohon Pie LLC</strong>
      </v-card-text>
    </v-card>
  </v-footer>
</template>

<script>
export default {
  data: () => ({
    icons: [
      'mdi-facebook',
      'mdi-twitter',
      'mdi-linkedin',
      'mdi-instagram',
    ],
  }),
}
</script>
