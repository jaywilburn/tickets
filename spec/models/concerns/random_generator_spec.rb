require 'rails_helper'

RSpec.describe RandomGenerator do

  let(:ticket) { create(:ticket) }
  let(:new_ticket) { build(:ticket) }

  describe "#generate_url_safe_random_token" do
    it "should generate a url safe random token" do
      expect(new_ticket.generate_url_safe_random_token(:external_identifier)).to be_a(String)
    end
  end
end
