<template>
  <div id="app">

    <tickets-nav></tickets-nav>

    <div class="container">
      <router-view></router-view>
      <hr>
      <tickets-footer></tickets-footer>
    </div> <!-- /container -->

  </div>
</template>

<script>
import Nav from './components/nav.vue'
import Footer from './components/footer.vue'
export default {
  components: {
    ticketsNav: Nav,
    ticketsFooter: Footer
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

</style>
