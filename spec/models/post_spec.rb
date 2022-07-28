require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:user) { User.create(email: 'example@new.com', password: 'password', password_confirmation: 'password') }
  subject(:post) { described_class.new(title: 'title', body: 'content', user_id: user.id, approved: true) }

  context "Associations" do
    it { should belong_to(:user) }

    it { should have_many(:comments) }

    it { should have_many(:likes) }
  end

  context "Validations" do 
    it { should validate_presence_of(:title) }
    
    it { should validate_presence_of(:body) }
  end
end