class Api::V1::SupportAgents::AssignatedTicketsController < Api::V1::BaseController

  def update
    authorize! :assignee, Ticket
    assignated_ticket = current_user.assignated_tickets.find(params[:external_identifier])
    if assignated_ticket.update_attributes(assignated_ticket_params)
      render json: assignated_ticket, status: :ok
    else
      api_error({ errors: assignated_ticket.errors, status: :bad_request })
    end
  end

  def assignated_ticket_params
    params.require(:assignated_ticket_params).permit(:subject, :description, :category, :priority)
  end

end


