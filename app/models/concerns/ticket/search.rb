module Concerns::Ticket::Search
  extend ActiveSupport::Concern

  class_methods do
    def search(options={})
      tickets = all
      if options
        tickets = tickets.by_subject_or_description_like(options[:by_subject_or_description_like]) if options[:by_subject_or_description_like]
        tickets = tickets.by_category(options[:by_category]) if options[:by_category]
        tickets = tickets.by_priority(options[:by_priority]) if options[:by_priority]
        tickets = tickets.by_status(options[:by_status]) if options[:by_status]
        tickets = tickets.by_external_identifier(options[:by_external_identifier]) if options[:by_external_identifier]
        tickets = tickets.by_requester_id(options[:by_requester_id]) if options[:by_requester_id]
        tickets = tickets.by_assigned_id(options[:by_assigned_id]) if options[:by_assigned_id]
        tickets = tickets.last_month if ActiveRecord::Type::Boolean.new.cast(options[:last_month])
      end
      tickets
    end
  end

end
