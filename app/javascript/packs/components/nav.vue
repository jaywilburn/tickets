<template>
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <li><router-link to="/">Home</router-link></li>
          <template v-if="user">
            <li v-if="user.type === 'Customer'"><router-link to="/c/tickets">Tickets</router-link></li>
            <li v-else><router-link to="/s/tickets">Tickets</router-link></li>
          </template>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li v-if="user"><a href @click.prevent="logOut">Logout</a></li>
          <li v-else><router-link to="/login">Login</router-link></li>
        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </nav>
</template>


<script>
import { bus } from '../tickets.js';

export default {
  data() {
    return {
      user: null
    }
  },
  methods: {
    logOut: function() {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      // this.$localStorage.remove('token');
      // this.$localStorage.remove('user');
      this.user = null;
      this.$router.push('/');
    }
  },
  created: function() {
    bus.$on('user', (user) => {
      this.user = user;
    });
    this.user = JSON.parse(localStorage.getItem('user')); // this.$localStorage.get('user');
  }
}
</script>