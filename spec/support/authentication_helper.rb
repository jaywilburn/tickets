module AuthenticationHelper

  def login_with(email, password)
    visit "/#/login"
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Login'
  end
end