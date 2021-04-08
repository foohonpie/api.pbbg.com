// Using CommonJS style module exporting here because this needs to be used in ./vue.config.js for
// sitemap generation which does not get transpiled.

const HOME_ROUTE = 'Home'
const LOGIN_ROUTE = 'Login'
const REGISTER_ROUTE = 'Register'
const ABOUT_ROUTE = 'About'

module.exports = {
  routes: [
    {
      path: '/',
      name: HOME_ROUTE,
      component: () => import(/* webpackChunkName: "home" */ '../views/Home.vue'),
    }, {
      path: '/login',
      name: LOGIN_ROUTE,
      component: () => import(/* webpackChunkName: "login" */ '../views/Login.vue'),
    }, {
      path: '/register',
      name: REGISTER_ROUTE,
      component: () => import(/* webpackChunkName: "register" */ '../views/Register.vue'),
    }, {
      path: '/about',
      name: ABOUT_ROUTE,
      component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
    },
  ],
  HOME_ROUTE,
  LOGIN_ROUTE,
  REGISTER_ROUTE,
  ABOUT_ROUTE,
}
