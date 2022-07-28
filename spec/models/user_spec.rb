require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(email: 'example@new.com', password: 'password', password_confirmation: 'password', role: "user") }

  context "Associations" do
    it { should have_many(:posts).dependent(:destroy) } 

    it { should have_many(:comments).dependent(:destroy) } 

    it { should have_many(:likes).dependent(:destroy) } 

    it { should have_many(:phones).dependent(:destroy) } 

    it { should have_many(:locations).dependent(:destroy) } 
  end

  context "Email validations" do
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context "Password validations" do 
    it { should validate_presence_of(:password) }

    it { should validate_length_of(:password).is_at_least(6)}

    it { should validate_confirmation_of(:password)}
  end

  context "User roles" do 
    it { should define_enum_for(:role).with_values(%i[user vip admin]) }
  end
end
