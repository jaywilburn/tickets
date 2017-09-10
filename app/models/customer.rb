class Customer < User

  has_many :requested_tickets, class_name: "Ticket", foreign_key: "requester_id"

end