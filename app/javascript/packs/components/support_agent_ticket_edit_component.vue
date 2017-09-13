<template>
  <div>
    <h1>Edit Ticket #{{ticket.external_identifier}}</h1>
    <hr>
    <form @submit.prevent="updateTicket">
      <div class="form-group">
        <label for="ticket-subject">Subject</label>
        <input type="text" class="form-control" name="ticket-subject" id="ticket-subject" placeholder="Subject" v-model="ticket.subject" disabled>
      </div>
      <div class="form-group">
        <label for="ticket-description">Description</label>
        <textarea class="form-control" rows="3" name="ticket-description" id="ticket-description" placeholder="Description" v-model="ticket.description" disabled></textarea>
      </div>
      <div class="form-group">
        <label for="ticket-priority">Priority</label>
        <select class="form-control" name="ticket-priority" id="ticket-priority" v-model="ticket.priority" disabled>
          <option v-for="priority in priorities">{{priority}}</option>
        </select>
      </div>
      <div class="form-group">
        <label for="ticket-category">Category</label>
        <select class="form-control" name="ticket-category" id="ticket-category" v-model="ticket.category" disabled>
          <option v-for="category in categories">{{category}}</option>
        </select>
      </div>
      <div class="form-group">
        <label for="ticket-status">Status</label>
        <select class="form-control" name="ticket-status" id="ticket-status" v-model="ticket.status">
          <option v-for="status in statuses">{{status}}</option>
        </select>
      </div>
      <button type="submit" class="btn btn-default">Submit</button>
    </form>
  </div>
</template>

<script>

export default {
  data() {
    return {
      ticket: {},
      statuses: ['pending', 'hold', 'solved', 'closed'],
      priorities: ['urgent', 'high', 'normal', 'low'],
      categories: ['problem', 'incident', 'question', 'task']
    }
  },
  methods: {
    updateTicket: function() {
      this.$http.put(`/api/tickets/${this.$route.params.externalIdentifier}.json`, {ticket: this.ticket}).then(response => {
        this.$router.push('/s/tickets');
      }, response => {
        alert(response.body.errors);
      });
    },
    loadTicket: function() {
      this.$http.get(`/api/tickets/${this.$route.params.externalIdentifier}.json`, {ticket: this.ticket}).then(response => {
        this.ticket = response.body.ticket;
        this.ticket.assigned_id = JSON.parse(localStorage.getItem('user')).id;
      }, response => {
        alert(response.body.errors);
      });
    }
  },
  watch: {
    $route() {
      this.loadTicket();
    }
  },
  created: function() {
    this.loadTicket();
  }
}
</script>