class Api::V1::Customers::RequestedTicketsController < Api::V1::BaseController

  def create
    authorize! :request, Ticket
    requested_ticket = current_user.requested_tickets.build(ticket_params)
    if requested_ticket.save
      render json: requested_ticket, status: :created
    else
      api_error({ errors: requested_ticket.errors, status: :bad_request })
    end
  end

  def ticket_params
    params.require(:ticket).permit(:subject, :description, :category, :priority)
  end

end


