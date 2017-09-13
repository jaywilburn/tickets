
Admin.create(name: "Admin", email: "admin@tickets.com", password: "password")

support_agent = SupportAgent.create(name: Faker::Name.name, email: "support_agent@tickets.com", password: "password")

customer = Customer.create(name: Faker::Name.name, email: "customer@tickets.com", password: "password")

15.times do
  Ticket.create(subject: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, category: Ticket::CATEGORY.sample, priority: Ticket::PRIORITY.sample, status: Ticket::STATUS.sample, requester: customer, assigned: support_agent)
end

5.times do
  Ticket.create(subject: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, category: Ticket::CATEGORY.sample, priority: Ticket::PRIORITY.sample, status: 'closed', requester: customer, assigned: support_agent)
end