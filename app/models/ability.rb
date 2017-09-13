class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    case user.type
    when "SupportAgent"
      can [:update], Ticket
    when "Customer"
      can [:request], Ticket
    end
  end
end
