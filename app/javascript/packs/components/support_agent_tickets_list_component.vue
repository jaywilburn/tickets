<template>
  <div>
    <h1>Tickets</h1>

    <hr>

    <div class="row">
      <div class="col-lg-6">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search by subject or description ..." v-model="q.by_subject_or_description_like">
          <span class="input-group-btn">
            <button class="btn btn-default" type="button" @click.prevent="loadTickets(1)">Search!</button>
          </span>
        </div><!-- /input-group -->
      </div><!-- /.col-lg-6 -->
      <button type="button" class="btn btn-default pull-right" @click.prevent="exportLastMonthClosedTickets"><span class="glyphicon glyphicon-export" aria-hidden="true"></span> Export last month closed tickets</button>
    </div><!-- /.row -->

    <br>

    <div class="row">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>External Identifier</th>
            <th>Subject</th>
            <th>Description</th>
            <th>Category</th>
            <th>Priority</th>
            <th>Status</th>
            <th>Requester Name</th>
            <th>Assignee Name</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="ticket in tickets" :key="ticket.external_identifier" @click.prevent="editTicket(ticket)">
            <td>{{ ticket.external_identifier }}</td>
            <td>{{ ticket.subject | truncate(20, '...') }}</td>
            <td>{{ ticket.description | truncate(20, '...') }}</td>
            <td>{{ ticket.category || 'N/A' }}</td>
            <td>{{ ticket.priority || 'N/A' }}</td>
            <td>{{ ticket.status || 'N/A' }}</td>
            <td>{{ ticket.requester_name || 'N/A' }}</td>
            <td>{{ ticket.assigned_name || 'N/A' }}</td>
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
    </div>

    <router-view></router-view>
  </div>
</template>

<script>

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
      q: { by_subject_or_description_like: '' },
      order: 'created_at DESC'
    }
  },
  methods: {
    loadTickets: function(page) {
      this.$http.get('/api/tickets.json', { params: { page: page, per: this.per, q: this.q, order: this.order } }).then(response => {
      this.tickets = response.body.tickets;
      this.totalPages = response.body.meta.total_pages;
      this.totalCount = response.body.meta.total_count;
      this.currentPages = response.body.meta.current_pages;
      this.nextPage = response.body.meta.next_page;
      this.prevPage = response.body.meta.next_page;
      }, response => {
        alert(response.body.errors);
      });
    },
    editTicket: function(ticket) {
      this.$router.push({ name: 'supportAgentTicketEdit', params: {externalIdentifier: ticket.external_identifier}});
    },
    exportLastMonthClosedTickets: function() {
      window.open('/tickets/export.pdf?&q%5Blast_month%5D=1&&q%5Bby_status%5D=closed');
    }
  },
  watch: {
    $route() {
      this.loadTickets();
    }
  },
  created: function() {
    this.loadTickets();
  }
}
</script>