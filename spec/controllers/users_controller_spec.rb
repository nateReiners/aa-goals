require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the sign up page" do
      get :new, user: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates presence of title and body" do
        post :create, user: { password: "short" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to user profile page" do
        post :create, user: { username: "something", password: "longer" }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe "GET #show" do
    let(:user) {User.new(username: "WalterWhite", password: "heisenberg") }

    it "shows the user's profile page" do
      get :show, user
      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end
  end

end
