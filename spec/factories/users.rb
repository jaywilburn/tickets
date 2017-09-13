FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
  end
  factory :customer, parent: :user, class: 'Customer' do
    email "#{Faker::Internet.user_name}@tickets.com"
  end
  factory :support_agent, parent: :user, class: 'SupportAgent' do
    email "#{Faker::Internet.user_name}@tickets.com"
  end
  factory :admin, parent: :user, class: 'Admin' do
    email "#{Faker::Internet.user_name}@tickets.com"
  end
end
