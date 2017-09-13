/* eslint no-console: 0 */
'use strict';

import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import vueFilter from 'vue-filter';

import App from './app.vue';
import { routes } from './routes.js';

Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(vueFilter);

Vue.http.interceptors.push((request, next) => {
  request.headers.set('Authorization', localStorage.getItem('token'));
  request.headers.set('Accept', 'application/json');
  next();
});

const router = new VueRouter({
  routes: routes
});

router.beforeEach((to, from, next) => {

  to.matched.some(record => {

    if (record.meta.requiresAuthentication) {
      // this route requires authentication, check if logged in
      // if not, redirect to login page.
      if (!JSON.parse(localStorage.getItem('user'))) {
        next({
          path: '/login'
        });
      } else {
        next();
      }
    } else {
      next();
    }

    if (record.meta.requiresAuthorizationFor) {
      // this route requires authorization, check if logged in
      // if not, redirect to home page.
      if (JSON.parse(localStorage.getItem('user')).type !== record.meta.requiresAuthorizationFor) {
        next({
          path: '/'
        });
      } else {
        next();
      }
    } else {
      next();
    }
  });

});

export var bus = new Vue();

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#tickets',
    router: router,
    render: h => h(App)
  });
});
