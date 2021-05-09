import Vue from "vue";
import Router from "vue-router";
import Landing from "./components/Landing.vue";
import Dashboard from "./components/Dashboard.vue";
import Buses from "./components/Buses.vue";
import ScheduledBuses from "./components/ScheduledBuses.vue";

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
    {
      path: "/scheduled_buses",
      name: "scheduled_buses",
      component: ScheduledBuses,
    },
  ],
});
