class SupportAgent < User

  has_many :assignated_tickets, class_name: "Ticket", foreign_key: "assignee_id"

end