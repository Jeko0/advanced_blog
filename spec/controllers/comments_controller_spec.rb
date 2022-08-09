require "rails_helper"

RSpec.describe CommentsController, type: :controller do 
  let(:myuser) { FactoryBot.attributes_for(:user) }
  let(:post) { FactoryBot.attributes_for(:post) }
  let(:new_comment) { FactoryBot.create(:comment) }

  before :each do 
    sign_in(myuser)
  end

  context "Post #create" do
    before { post :create, params: {
      id: new_comment.id,
      post: new_comment
    }
  }
    it { should redirect_to(post_path)}
  end
end