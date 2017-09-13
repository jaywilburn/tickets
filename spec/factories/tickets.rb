FactoryGirl.define do
  factory :ticket do
    subject Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    category Ticket::CATEGORY.sample
    priority Ticket::PRIORITY.sample
    status Ticket::STATUS.sample
  end
end
