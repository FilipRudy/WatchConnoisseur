require 'rails_helper'

RSpec.describe WatchesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  describe "GET /watches" do
    before do
      create(:watch, user_id: user.id)
      create(:watch, user_id: user.id)
    end

    it "should return all watches" do
      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /watches" do
    it "should add a new watch" do
      sign_in user
      expect {
        post :create, params: { watch: { name: "Test", description: "watch", category: "premium", price: 1000000, photo_url: "href", user_id: user.id } }
      }.to change { Watch.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end

    it "should return an unprocessable entity error if parameters are missing" do
      sign_in user
      post :create, params: { watch: { description: "watch", category: "premium", photo_url: "href", user_id: user.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return an unauthorized error if the user is not signed in" do
      post :create, params: { watch: { name: "Test", description: "watch", category: "premium", price: 1000000, photo_url: "href", user_id: user.id } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /watches" do
    let!(:watch) { create(:watch, user_id: user.id) }

    it "should delete a watch" do
      sign_in user
      expect {
        delete :destroy, params: { id: watch.id }
      }.to change { Watch.count }.from(1).to(0)

      expect(response).to have_http_status(:ok)
    end
  end


  describe "PUT /watches/:id" do
    let(:watch) { create(:watch, user_id: user.id) }

    it "should update a watch" do
      sign_in user
      new_name = "Updated name"
      put :update, params: { id: watch.id, watch: { name: new_name } }

      expect(response).to have_http_status(:success)
      expect(watch.reload.name).to eq(new_name)
    end

    it "should return a not found error when the watch does not exist" do
      sign_in user
      put :update, params: { id: 444, watch: { name: "Test" } }

      expect(response).to have_http_status(:not_found)
    end

    it "should return an unprocessable entity error if the user is not authorized" do
      unauthorized_user = create(:user)
      sign_in unauthorized_user
      put :update, params: { id: watch.id, watch: { name: "Test" } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
