<template>
  <div>
    <h1>Your Tickets</h1>

    <hr>

    <table class="table table-hover">
      <thead>
        <tr>
          <th>External Identifier</th>
          <th>Subject</th>
          <th>Description</th>
          <th>Category</th>
          <th>Priority</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="ticket in tickets" :key="ticket.external_identifier">
          <td>{{ ticket.external_identifier }}</td>
          <td>{{ ticket.subject | truncate(20, '...') }}</td>
          <td>{{ ticket.description | truncate(20, '...') }}</td>
          <td>{{ ticket.category || 'N/A' }}</td>
          <td>{{ ticket.priority || 'N/A' }}</td>
          <td>{{ ticket.status || 'N/A' }}</td>
        </tr>
      </tbody>
    </table>

    <nav>
      <ul class="pagination">
        <li>
          <a href aria-label="Previous" @click.prevent="loadTickets(prevPage)">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li v-for="n in totalPages"><a href @click.prevent="loadTickets(n)">{{n}}</a></li>
        <li>
          <a href aria-label="Next" @click.prevent="loadTickets(nextPage)">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>

    <customer-new-ticket></customer-new-ticket>

  </div>
</template>

<script>
import CustomerNewTicketComponent from './customer_new_ticket_component.vue'
import { bus } from '../tickets.js';

export default {
  data() {
    return {
      tickets: [],
      totalPages: 0,
      totalCount: 0,
      currentPage: 1,
      nextPage: 0,
      prevPage: 0,
      per: 5,
      order: 'created_at DESC'
    }
  },
  methods: {
    loadTickets: function(page) {
      this.$http.get('/api/tickets.json', { params: { page: page, per: this.per, q: { by_requester_id: JSON.parse(localStorage.getItem('user')).id }, order: this.order } }).then(response => {
      this.tickets = response.body.tickets;
      this.totalPages = response.body.meta.total_pages;
      this.totalCount = response.body.meta.total_count;
      this.currentPages = response.body.meta.current_pages;
      this.nextPage = response.body.meta.next_page;
      this.prevPage = response.body.meta.next_page;
      }, response => {
        alert(response.body.errors);
      });
    }
  },
  created: function() {
    bus.$on('ticket', (ticket) => {
      this.tickets.unshift(ticket);
    });
    this.loadTickets();
  },
  components: {
    CustomerNewTicket: CustomerNewTicketComponent
  }
}
</script>