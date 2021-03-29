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
      v-if="$route.name !== $options.LOGIN_ROUTE"
      text
      to="Login"
    >
      <span>Login</span>
      <v-icon>mdi-login</v-icon>
    </v-btn>
    <v-btn
      v-else
      text
      to="Register"
    >
      <span>Register</span>
      <v-icon>mdi-register</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
const { LOGIN_ROUTE } = require('@/router/routes')

export default {
  LOGIN_ROUTE,
  data: () => ({}),
}
</script>
