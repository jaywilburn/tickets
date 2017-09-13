require 'prawn'
require 'prawn/table'

class TicketsPdfExport < Prawn::Document

  DEFAULT_HEADER_TITLE   = "Report"
  DEFAULT_HEADER_MESSAGE = "Closed tickets from last month."
  DEFAULT_FOOTER_MESSAGE  = "Tickets, Inc."

  attr_reader :custom_font, :tickets, :header_title, :header_message, :footer_message

  def initialize(attributes)
    @attributes     = attributes
    @tickets        = attributes.fetch(:tickets)
    @custom_font    = attributes.fetch(:font, {})
    @header_title   = attributes.fetch(:header_title) { DEFAULT_HEADER_TITLE }
    @header_message = attributes.fetch(:header_message) { DEFAULT_HEADER_MESSAGE }
    @footer_message  = attributes.fetch(:footer_message) { DEFAULT_FOOTER_MESSAGE }

    super(margin: 0)

    setup_fonts if custom_font.any?
    generate
  end

  private

    def table_headers
      ['Category', 'Priority', 'Status', 'External Identifier', 'Requester Name', 'Assignee Name']
    end

    def exportables
      tickets.includes(:requester, :assigned).map do |ticket|
        [
          ticket.category || 'N/A',
          ticket.priority || 'N/A',
          ticket.status || 'N/A',
          ticket.external_identifier,
          ticket.requester_name || 'N/A',
          ticket.assigned_name || 'N/A'
        ]
      end
    end

    def setup_fonts
      font_families.update "Primary" => custom_font
      font "Primary"
    end

    def generate
      bounding_box [0, 792], width: 620, height: 792 do
        bounding_box [60, 792], width: 600, height: 792 do
          header
          body
          footer
        end
      end
    end

    def header
      move_down 100

      text "<color rgb='a6a6a6'>#{header_title}</color>", inline_format: true

      move_down 30
      text header_message, inline_format: true, size: 12.5, leading: 4
    end

    def body
      move_down 30

      table_rows = exportables.insert(0, table_headers)

      borders = table_rows.length - 2

      table(table_rows, cell_style: { border_color: 'cccccc' }) do
        cells.padding = 5
        cells.borders = []
        row(0..borders).borders = [:bottom]
      end
    end

    def footer
      move_down 45
      text footer_message, inline_format: true
    end
end
