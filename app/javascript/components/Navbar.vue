<template>
  <div>
    <div class="navbar">
      <b-navbar toggleable="sm" type="light" variant="light">
        <router-link class="nav-link" to="/">
          <b-navbar-brand>Mawasalati</b-navbar-brand></router-link
        >

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav>
            <b-nav-item>
              <router-link class="nav-link" to="/buses"
                >Buses</router-link
              ></b-nav-item
            >

            <!-- <b-nav-item href="#" disabled>Disabled</b-nav-item> -->
          </b-navbar-nav>

          <b-navbar-nav class="ml-auto">
            <b-nav-item-dropdown v-if="isLogged === true" right>
              <template #button-content>
                <img
                  src="../assets/user.png"
                  alt=""
                  width="35px"
                  height="35px"
                />
              </template>
              <!-- <router-link class="nav-link" to="/profile">
                <b-dropdown-item href="/profile"
                  >Profile</b-dropdown-item
                ></router-link
              > -->

              <b-dropdown-item @click="logout()" href="#"
                >Sign Out</b-dropdown-item
              >
            </b-nav-item-dropdown>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
    </div>
  </div>
</template>

<script>
import EventBus from "../EventBus";
export default {
  template: "navbar",
  name: "navbar",
  data() {
    return {
      isLogged: false,
    };
  },
  created() {
    EventBus.$on("logged", (value) => {
      console.log(value);
      this.isLogged = this.checkIfIsLogged();
    });
  },
  methods: {
    logout() {
      localStorage.removeItem("userInfo");
      this.$router.push("/");
      this.isLogged = this.checkIfIsLogged();
    },
    checkIfIsLogged() {
      let token = localStorage.getItem("userInfo");
      if (token) {
        return true;
      } else {
        return false;
      }
    },
  },
};
</script>
<style scoped>
.navbar {
  width: 100%;
}

/* .bg-info {
  background-color: #ffffff !important;
} */
</style>
