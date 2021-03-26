<template>
  <v-form
    v-model="valid"
    @submit.prevent
  >
    <v-jsf
      v-model="formModels"
      :schema="formSchema"
      :options="formOptions"
    />
    <a-button
      v-for="button of buttons"
      :key="button.buttonText"
      :type="button.type"
      :color="button.color"
      :style-classes="button.styleClasses"
      @click="button.clickHandler(formModels)"
      :disabled="button.disableWhenInvalidForm ? !valid : false"
    >
      {{ button.buttonText }}
    </a-button>
  </v-form>
</template>

<script>
export default {
  props: {
    models: {
      type: Object,
      required: true,
    },
    schema: {
      type: Object,
      required: true,
    },
    options: {
      type: Object,
      default: () => {},
    },
    buttons: {
      type: Array,
      default: () => [],
    },
  },
  components: {
    VJsf: () => import('@koumoul/vjsf/lib/VJsf.js'),
    AButton: () => import('./atoms/AButton.vue'),
  },
  data() {
    return {
      valid: false,
      formModels: this.models,
      formSchema: this.schema,
      formOptions: this.options,
    }
  },
}
</script>
