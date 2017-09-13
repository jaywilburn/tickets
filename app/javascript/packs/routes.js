import HomeComponent from './components/home.vue';
import AthenticationComponent from './components/authentication.vue';
import CustomerTicketsListComponent from './components/customer_tickets_list_component.vue';
import SupportAgentTicketsListComponent from './components/support_agent_tickets_list_component.vue';
import SupportAgentTicketEditComponent from './components/support_agent_ticket_edit_component.vue';

export const routes = [
  { path: '', component: HomeComponent },
  { path: '/login', component: AthenticationComponent },
  { path: '/c/tickets', component: CustomerTicketsListComponent, meta: { requiresAuthentication: true, requiresAuthorizationFor: 'Customer' } },
  { path: '/s/tickets', component: SupportAgentTicketsListComponent, meta: { requiresAuthentication: true, requiresAuthorizationFor: 'SupportAgent' }, children: [
    { path: ':externalIdentifier/edit', name: 'supportAgentTicketEdit', component: SupportAgentTicketEditComponent },
  ] },
  { path: '*', redirect: '/' }
];