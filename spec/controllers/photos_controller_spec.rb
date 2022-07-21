require 'rails_helper'

RSpec.describe PhotosController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      user = create(:user)
      sign_in :user, user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = create(:user)
      sign_in :user, user
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
