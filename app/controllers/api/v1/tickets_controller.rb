class Api::V1::TicketsController < Api::V1::BaseController

  def index
    tickets = Ticket.search(params[:search]).page(params[:page]).per(params[:per])
    if stale?(tickets)
      render json: tickets, status: :ok
    end
  end

  def show
    ticket = Ticket.find(params[:external_identifier])
    if stale?(ticket)
      render json: ticket, status: :ok
    end
  end

end


