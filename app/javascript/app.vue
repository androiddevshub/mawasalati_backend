<template>
  <div id="app">
    <Navbar />
    <div class="main">
      <router-view />
    </div>
  </div>
</template>

<script>
import Navbar from "./components/Navbar.vue";
export default {
  name: "app",
  components: { Navbar },
  data: function() {
    return {};
  },
  created() {},
  methods: {},
  computed: {},
};
</script>

<style scoped>
.navbar {
  width: 100%;
}
.container {
  width: 100%;
}
/* .bg-info {
  background-color: #ffffff !important;
} */
</style>
