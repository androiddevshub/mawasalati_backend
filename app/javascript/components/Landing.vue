<template>
  <div class="main">
    <div id="login-page" class="login-page">
      <div class="form">
        <form class="register-form" v-show="showRegisterForm">
          <input type="text" v-model="formData.name" placeholder="Name" />
          <input type="email" v-model="formData.email" placeholder="Email" />
          <input type="phone" v-model="formData.phone" placeholder="Phone" />
          <input
            type="textarea"
            v-model="formData.address"
            placeholder="Address"
          />
          <input
            type="password"
            v-model="formData.password"
            placeholder="password"
          />
          <button @click.prevent="registerFun()">Register</button>
          <p class="message">
            Already registered?
            <a href="#" @click.prevent="toggleForm('login')">Sign In</a>
          </p>
        </form>
        <form class="login-form" v-show="showLoginForm">
          <input type="email" v-model="formData.email" placeholder="Email" />
          <input
            type="password"
            v-model="formData.password"
            placeholder="password"
          />
          <button @click.prevent="loginFun()">login</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import EventBus from "../EventBus";
export default {
  name: "Landing",
  data() {
    return {
      login_message: "Please enter your credentials to login.",
      loginStage: "login-form",
      currentForm: "login",
      location: null,
      gettingLocation: false,
      errorStr: null,
      formData: {
        name: "",
        email: "",
        phone: "",
        address: "",
        password: "",
        latitude: "",
        longitude: "",
      },
    };
  },
  created() {
    this.checkUser();
  },
  computed: {
    showRegisterForm() {
      return this.currentForm === "register";
    },
    showLoginForm() {
      return this.currentForm === "login";
    },
  },
  methods: {
    checkUser() {
      if (localStorage.getItem("userInfo")) {
        this.$router.push("/dashboard");
      }
    },
    toggleForm(formName) {
      this.currentForm = formName;
    },
    registerFun() {
      var _this = this;
      // this.getGeoLocation();
      if (this.formData.name === "" && this.formData.email === "") {
        _this.$notify.error({
          title: "Error",
          message: "Location not fetched",
        });
      } else {
        axios
          .post("/api/users", this.formData)
          .then(function(response) {
            _this.$notify({
              title: "Success",
              message: "User is registered as successfully",
              type: "success",
            });
            _this.currentForm = "login";
          })
          .catch(function(error) {
            _this.$notify.error({
              title: "Error",
              message: error.response.data.message,
            });
          });
      }
    },
    loginFun() {
      var _this = this;
      axios
        .post("/api/users/login", {
          email: this.formData.email,
          password: this.formData.password,
        })
        .then(function(response) {
          console.log(response);
          const data = response.data;
          _this.$notify({
            title: "Success",
            message: data.message,
            type: "success",
          });

          localStorage.setItem(
            "userInfo",
            JSON.stringify({ user: data.user, loggedIn: true })
          );
          EventBus.$emit("logged", "User logged In successfully");

          _this.$router.push("/dashboard");
        })
        .catch(function(error) {
          console.log(error.response);
          _this.$notify.error({
            title: "Error",
            message: error.response.data.message,
          });
        });
    },
    async getGeoLocation() {
      const _this = this;
      console.log("function stary 1");
      if (navigator.geolocation) {
        console.log("function stary 2");
        this.gettingLocation = true;
        navigator.geolocation.getCurrentPosition(
          function(position) {
            _this.gettingLocation = false;
            _this.location = position;
            _this.formData.latitude = _this.location.coords.latitude;
            _this.formData.longitude = _this.location.coords.longitude;
          },
          function(error) {
            console.log("error->", error);
            _this.errorStr = error;
            return;
          },
          {
            enableHighAccuracy: true,
            Infinity: Infinity,
            timeout: 2000,
          }
        );
      } else {
        _this.errorStr = "Geolocation is not available.";
        return;
      }
    },
  },
};
</script>

<style scoped>
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.main {
  width: 100%;
  display: flex;
}

.login-page {
  width: 450px;
  padding: 8% 0 0;

  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #ffffff;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #4caf50;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #ffffff;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,
.form button:active,
.form button:focus {
  background: #43a047;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #4caf50;
  text-decoration: none;
}
</style>
