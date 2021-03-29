<template>
  <base-layout>
    <v-row class="justify-center fill-height pt-8">
      <v-col class="col-xl-4 col-lg-4 col-md-6 col-sm-8 col-xs-12">
        <h1>
          Register
        </h1>
        <form-generator
          :models="userRegisterForm.models"
          :schema="userRegisterForm.schema"
          :options="userRegisterForm.options"
          :buttons="userRegisterForm.buttons"
        />
      </v-col>
    </v-row>
  </base-layout>
</template>

<script>
import { userRegisterForm } from '../formDescriptors'

export default {
  name: 'Register',
  metaInfo: {title: 'Register'},
  components: {
    BaseLayout: () => import('./layouts/BaseLayout.vue'),
    FormGenerator: () => import('../components/FormGenerator.vue'),
  },
  data: () => ({
    userRegisterForm,
  }),
}
</script>
