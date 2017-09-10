module RandomGenerator
  extend ActiveSupport::Concern

  # generate_url_safe_random_token
  # Description:
  # - Generates url safe base 64 random codes
  #   looks until it finds a record that does not exist
  #   given the generated output
  def generate_url_safe_random_token(column)
    begin
      random = SecureRandom.urlsafe_base64
    end while self.class.name.constantize.exists?(column => random)
    random
  end
end
