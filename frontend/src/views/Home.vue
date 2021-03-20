<template>
  <div class="home">
    <hello-world />
  </div>
</template>

<script>
export default {
  name: 'Home',
  metaInfo: { title: 'PBBG' },
  components: {
    HelloWorld: () => import('../components/HelloWorld.vue'),
  },
}
</script>
