require 'rails_helper'

RSpec.describe PostsController, type: :controller do  
  let(:user) { FactoryBot.create(:user)}
  let(:new_post) { FactoryBot.attributes_for(:post)}
  let(:mypost) { FactoryBot.create(:post) }

  before :each do 
    sign_in(user)
  end 

  context "Before action" do
    it { should use_before_action(:set_post) }

    it { should use_before_action(:logged_in?) }

    it { should use_before_action(:require_authorize_post!) }
  end

  context "GET #index" do
    before { get :index }
    it { should render_template("index") }
  end

  context "GET #new" do 
    before { get :new }
    it { should render_template(:new) }
  end

  context "Post #Create" do
    before { post :create, params: { post: new_post } }

    it { should redirect_to(post_path(Post.last)) }

    it { should set_flash }
  end

  context "Patch #update" do
    before { patch :update, params: { id: mypost.id, post: { :title => "new title" } }
      mypost.reload
      }

    it { expect(mypost.title).to eq("new title") }

    it { should set_flash }
  end

  context "Delete #destroy" do
    before { delete :destroy, params: {
      id: mypost.id ,
      post: new_post
     }
     mypost.destroy
   }

   it { should redirect_to(root_path)}

   it { should set_flash }
  end
end
