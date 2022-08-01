require "rails_helper"


RSpec.describe HomeController, type: :controller do
  context "GET #index" do
    subject { get :index } 
    it { should have_http_status(:success) }
  end

  context "profile" do 
    it "routes to #profile" do
      expect(get: "/user_profile/:id").to route_to({
        controller: "home",
        action: "profile",
        id: ":id"
      })
    end
  end
end
