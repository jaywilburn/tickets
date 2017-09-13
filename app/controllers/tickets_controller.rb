class TicketsController < ApplicationController

  def export
    respond_to do |format|
      format.pdf {
        send_data Ticket.search(params[:q]).export_as_pdf.render,
          filename: "tickets.pdf",
          type: "application/pdf",
          disposition: :inline
      }
    end
  end
end
