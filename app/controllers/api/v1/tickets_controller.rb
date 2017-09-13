class Api::V1::TicketsController < Api::V1::BaseController

  def index
    tickets = Ticket.search(params[:q]).order(params[:order]).page(params[:page]).per(params[:per])
    if stale?(tickets)
      render json: tickets, include: ['requester', 'assigned'], meta: pagination_dict(tickets), status: :ok
    end
  end

  def show
    ticket = Ticket.find_by!(external_identifier: params[:external_identifier])
    if stale?(ticket)
      render json: ticket, status: :ok
    end
  end

  def update
    authorize! :update, Ticket
    ticket = Ticket.find_by!(external_identifier: params[:external_identifier])
    if ticket.update_attributes(ticket_params)
      render json: ticket, status: :ok
    else
      api_error({ errors: ticket.errors, status: :bad_request })
    end
  end

  def ticket_params
    params.require(:ticket).permit(:status, :assigned_id)
  end

end


