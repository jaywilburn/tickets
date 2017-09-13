<template>
  <div>
    <h1>Create Ticket</h1>
    <hr>
    <form @submit.prevent="createTicket">
      <div class="form-group">
        <label for="ticket-subject">Subject</label>
        <input type="text" class="form-control" name="ticket-subject" id="ticket-subject" placeholder="Subject" v-model="ticket.subject">
      </div>
      <div class="form-group">
        <label for="ticket-description">Description</label>
        <textarea class="form-control" rows="3" name="ticket-description" id="ticket-description" placeholder="Description" v-model="ticket.description"></textarea>
      </div>
      <div class="form-group">
        <label for="ticket-priority">Priority</label>
        <select class="form-control" name="ticket-priority" id="ticket-priority" v-model="ticket.priority">
          <option v-for="priority in priorities">{{priority}}</option>
        </select>
      </div>
      <div class="form-group">
        <label for="ticket-category">Category</label>
        <select class="form-control" name="ticket-category" id="ticket-category" v-model="ticket.category">
          <option v-for="category in categories">{{category}}</option>
        </select>
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
      ticket: {subject: '', description: '', priority: '', category: ''},
      priorities: ['urgent', 'high', 'normal', 'low'],
      categories: ['problem', 'incident', 'question', 'task']
    }
  },
  methods: {
    createTicket: function() {
      this.$http.post('/api/requested_tickets.json', {ticket: this.ticket}).then(response => {
        bus.$emit('ticket', response.body);
        this.ticket = {subject: '', description: '', priority: '', category: ''};
      }, response => {
        alert(response.body.errors);
      });
    }
  }
}
</script>