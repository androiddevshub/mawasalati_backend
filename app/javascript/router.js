import Vue from "vue";
import Router from "vue-router";
import Landing from "./components/Landing.vue";
import Dashboard from "./components/Dashboard.vue";
import Buses from "./components/Buses.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  // base: "frontend",
  // history: createWebHistory("/frontend/"),
  routes: [
    {
      path: "/",
      name: "Landing",
      component: Landing,
    },
    {
      path: "/dashboard",
      name: "home",
      component: Dashboard,
    },
    {
      path: "/buses",
      name: "buses",
      component: Buses,
    },
  ],
});
