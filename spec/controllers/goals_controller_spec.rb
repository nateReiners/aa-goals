require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:nate) { User.create!(username: 'natedogg', password: 'password') }

  before(:each) do
   allow_message_expectations_on_nil
  end

  describe "GET #new" do
    context "when logged in" do

      before do
        allow(controller).to receive(:current_user) { nate }
      end

      it "renders the new goal page" do
        get :new, goal: {}
        expect(response).to render_template("new")
        expect(response).to have_http_status(200)
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        get :new, goal: {}
        expect(response).to redirect_to(new_session_url)
      end
    end

  end

  describe "POST #create" do
    let(:nate) { User.create!(username: 'natedogg', password: 'password') }

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        post :create, goal: {}
        expect(response).to redirect_to(new_session_url)
      end
    end

    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { nate }
      end


      context "with invalid params" do

        it "validates presence of title, body, and user" do
          post :create, goal: { title: "goaltitle" }
          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
        end
      end

      context "with valid params" do
        it "redirects to goal show page" do
          post :create, goal: {title: 'titlelsdkfjdskl', body: 'bodybodybodybody', user_id: nate.id }
          expect(response).to redirect_to(goal_url(Goal.last))
        end
      end

    end
  end

end
