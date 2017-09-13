# README

* Ruby version

  2.3.1

* System dependencies

  - MySQL 5.7.17
  - Yarn 1.0.1
  - NodeJS 8.1.4

* Database creation

  rails db:create

* Database initialization

  rails db:migrate
  rails db:seed

* Install

  bundle

* Running

  foreman start

* How to run the test suite

  bundle exec rspec

* Constructive feedback for improving the assignment

  There should be a requirement that the status must be updated in an specific order using the state pattern, like AASM. e.g: You can change the status from 'open' to 'closed', but can't change from 'closed' to 'open'.

* Credentials

  Customer: customer@tickets.com | password
  SupportAgent: support_agent@tickets.com | password
  Admin: admin@tickets.com | password
