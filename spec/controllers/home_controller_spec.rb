require "rails_helper"


RSpec.describe HomeController, type: :controller do
  context "GET #index" do
    subject { get :index } 
    it { should have_http_status(:success) }
  end
end
