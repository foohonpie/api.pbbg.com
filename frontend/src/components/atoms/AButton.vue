<template>
  <v-btn
    :type="type"
    :disabled="disabled"
    :color="color"
    elevation="2"
    :loading="loading"
    :[size]="true"
    @click="$emit('click')"
    :class="classes"
  >
    <slot />
  </v-btn>
</template>

<script>
export default {
  props: {
    type: {
      type: String,
      default: 'text',
    },
    size: {
      type: String,
      default: 'medium',
      validator: value => ['small', 'medium', 'large', 'x-small', 'x-large'].includes(value),
    },
    loading: {
      type: Boolean,
      default: false,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    styleClasses: {
      type: Array,
      default: () => [],
    },
    color: {
      type: String,
      default: 'primary',
    },
  },
  computed: {
    classes() {
      return this.styleClasses.length ? this.styleClasses.join(' ') : null
    },
  },
}
</script>
