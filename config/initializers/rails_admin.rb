RailsAdmin.config do |config|

  config.authenticate_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      user = Admin.by_lower_email(username).first
      user if user.try(:authenticate, password)
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.excluded_models = ["User", "Admin"]

  config.model 'Ticket' do
    create do
      exclude_fields :status, :external_identifier
    end
    edit do
      exclude_fields :status, :external_identifier
    end
  end

  config.model 'SupportAgent' do
    field :name
    field :email
    field :password
    field :password_confirmation
    field :assigned_tickets
    exclude_fields :password_digest
  end

  config.model 'Customer' do
    field :name
    field :email
    field :password
    field :password_confirmation
    field :requested_tickets
    exclude_fields :password_digest
  end
end
