class SupportAgent < User

  has_many :assigned_tickets, class_name: "Ticket", foreign_key: "assigned_id"

end