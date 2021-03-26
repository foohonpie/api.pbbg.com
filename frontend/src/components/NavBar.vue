<template>
  <v-app-bar
    color="primary"
    dark
    app
  >
    <div class="d-flex align-center">
      <router-link to="/">
        <v-img
          :src="require('../assets/logo.png')"
          width="2.5rem"
          alt="PBBG Logo"
          contain
        />
      </router-link>
      <div class="hidden-sm-and-down">
        Persistent Browser Based Games
      </div>
    </div>

    <v-spacer />

    <v-btn
      text
      to="Login"
    >
      <span>Login</span>
      <v-icon>mdi-login</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  data: () => ({}),
}
</script>
