<template>
  <div>
    <p>Buses</p>
  </div>
</template>
<script>
import EventBus from "../EventBus";
export default {
  name: "Buses",
  data() {
    return {
      userInfo: {},
    };
  },
  created() {
    if (this.checkIfIsLogged) {
      console.log("inside here logged");
    }
  },
  computed: {
    checkIfIsLogged() {
      console.log(localStorage);
      let token = localStorage.getItem("userInfo");
      if (token) {
        EventBus.$emit("logged", "User logged");
        this.userInfo = JSON.parse(localStorage.getItem("userInfo"));

        return true;
      } else {
        console.log("Sorry, you aren't logged in");
        this.$router.push("/");
        return false;
      }
    },
  },
};
</script>
<style scoped></style>
