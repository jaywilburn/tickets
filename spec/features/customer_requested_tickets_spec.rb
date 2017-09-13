require 'rails_helper'

feature 'Customer Requested Tickets' do

  let(:customer) { create(:customer) }
  let(:ticket) { create(:ticket, requester: customer) }
  let(:new_ticket) { build(:ticket) }

  before do
    login_with customer.email, 'password'
  end

  scenario 'see my tickets' do
    expect(page).to have_content(ticket.external_identifier)
  end

  scenario 'create a new ticket' do
    fill_in 'Subject', with: new_ticket.subject
    fill_in 'Subject', with: new_ticket.description
    select new_ticket.priority, from: 'ticket-priority'
    select new_ticket.category, from: 'ticket-category'
    click_button 'Submit'
    expect(page).to have_content('Ticket has been created')
  end

end