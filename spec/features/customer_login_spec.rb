require 'rails_helper'

feature 'Customer login' do

  let(:customer) { create(:customer) }

  scenario 'with valid email and password' do
    login_with customer.email, 'password'

    expect(page).to have_content('Logout')
  end

  scenario 'with invalid email' do
    login_with 'invalid_email', 'password'

    expect(page).to have_content('Login')
  end

  scenario 'with blank password' do
    login_with 'valid@example.com', ''

    expect(page).to have_content('Login')
  end
end