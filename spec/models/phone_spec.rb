require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe "phone" do 
    context "Associations" do
      it { should belong_to(:user) } 
    end
  end
end
