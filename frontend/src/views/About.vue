<template>
  <base-layout>
    <h1>About Us</h1>
  </base-layout>
</template>

<script>
export default {
  name: 'About',
  components: {
    BaseLayout: () => import('./layouts/BaseLayout.vue'),
  },
  metaInfo: { title: 'About Us' },
}
</script>
