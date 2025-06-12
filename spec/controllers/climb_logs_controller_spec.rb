require 'rails_helper'
require 'devise'

RSpec.describe ClimbLogsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:climb_log) { FactoryBot.create(:climb_log, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new climb_log" do
        expect {
          post :create, params: { climb_log: FactoryBot.attributes_for(:climb_log) }
        }.to change(ClimbLog, :count).by(1)
      end

      it "redirects to the created climb_log" do
        post :create, params: { climb_log: FactoryBot.attributes_for(:climb_log) }
        expect(response).to redirect_to(climb_log_url(ClimbLog.last))
      end
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: climb_log.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: climb_log.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    it "redirects to the updated climb_log" do
      patch :update, params: { id: climb_log.id, climb_log: { date: climb_log.date, location: climb_log.location, route_name: climb_log.route_name } }
      expect(response).to redirect_to(climb_log_url(climb_log))
    end
  end

  describe "DELETE #destroy" do
    it "destroys the climb_log" do
      climb_log # Ensure climb_log is created before destroy
      expect {
        delete :destroy, params: { id: climb_log.id }
      }.to change(ClimbLog, :count).by(-1)
    end

    it "redirects to the climb_logs list" do
      delete :destroy, params: { id: climb_log.id }
      expect(response).to redirect_to(climb_logs_url)
    end
  end
end
