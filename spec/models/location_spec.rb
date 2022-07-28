require 'rails_helper'

RSpec.describe Location, type: :model do
 
  context "Associations" do
    it { should belong_to(:user) } 
  end

  context "Validations" do
    it { should validate_presence_of(:street) }

    it { should validate_presence_of(:city) }

    it { should validate_presence_of(:state) }

    it { should validate_presence_of(:country) }
  end
end
