<template>
  <base-layout>
    <v-row class="justify-center fill-height pt-8">
      <v-col
        class="col-xl-4 col-lg-4 col-md-6 col-sm-8 col-xs-12"
      >
        <h1>
          Login
        </h1>
        <form-generator
          :models="userLoginForm.models"
          :schema="userLoginForm.schema"
          :options="userLoginForm.options"
          :buttons="userLoginForm.buttons"
        />
      </v-col>
    </v-row>
  </base-layout>
</template>

<script>
import { userLoginForm } from '../formDescriptors'

export default {
  name: 'Login',
  metaInfo: { title: 'Login' },
  components: {
    BaseLayout: () => import('./layouts/BaseLayout.vue'),
    FormGenerator: () => import('../components/FormGenerator.vue'),
  },
  data: () => ({
    userLoginForm,
  }),
}
</script>
