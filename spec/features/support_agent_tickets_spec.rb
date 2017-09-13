require 'rails_helper'

feature 'SupportAgent Tickets' do

  let(:support_agent) { create(:support_agent) }
  let(:ticket) { create(:ticket, assigned: support_agent) }

  before do
    login_with support_agent.email, 'password'
  end

  scenario 'see all tickets' do
    expect(page).to have_content(ticket.external_identifier)
  end

end