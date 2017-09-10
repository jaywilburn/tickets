class Api::V1::Customers::RequestedTicketsController < Api::V1::BaseController

  def create
    authorize! :request, Ticket
    requested_tickets = current_user.requested_tickets.build(requested_ticket_params)
    if requested_ticket.save
      render json: requested_ticket, status: :created
    else
      api_error({ errors: requested_ticket.errors, status: :bad_request })
    end
  end

  def requested_ticket_params
    params.require(:requested_ticket_params).permit(:subject, :description, :category, :priority)
  end

end


