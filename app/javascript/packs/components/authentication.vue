<template>
  <div>
    <h1>Login</h1>
    <hr>
    <form @submit.prevent="authenticate">
      <div class="form-group">
        <label for="user-email">Email address</label>
        <input type="email" class="form-control" name="user-email" id="user-email" placeholder="Email" v-model="user.email">
      </div>
      <div class="form-group">
        <label for="user-password">Password</label>
        <input type="password" class="form-control" name="user-password" id="user-password" placeholder="Password" v-model="user.password">
      </div>
      <button type="submit" class="btn btn-default">Submit</button>
    </form>
  </div>
</template>

<script>
import { bus } from '../tickets.js';

export default {
  data() {
    return {
      user: {
        email: '', password: ''
      }
    }
  },
  methods: {
    authenticate: function() {
      this.$http.post('/api/authentications.json', {user: this.user}).then(response => {

        if (response.body.user.hasOwnProperty('customer')) {
          var type = 'customer', route = '/c/tickets';
        } else {
          var type = 'support_agent', route = '/s/tickets';
        }

        bus.$emit('user', response.body.user[type]);

        localStorage.setItem('token', response.body.token);
        localStorage.setItem('user', JSON.stringify(response.body.user[type]));

        this.$router.push(route);
      }, response => {
        alert(response.body.errors);
      });
    }
  }
}
</script>