require 'rails_helper'

describe EpisodesController do
  let(:user) { create(:user) }

  before do
    request.headers['X-User-Email'] = user.email
    request.headers['X-User-Token'] = user.authentication_token
  end

  describe "GET #index" do
    let(:action) { -> { get :index, tv_show_id: 1 } }
    let(:service_class) { Episodes::Fetcher }

    service_oriented_action
  end

  describe "GET #show" do
    it 'creates a result by itself' do
      result = double(:render)
      allow(Answer).to receive(:new).and_return(result)

      expect(result).to receive(:render)

      get :show, id: 1
    end
  end

  describe "POST #create" do
    let(:action) { -> { post :create, tv_show_id: 1 } }
    let(:service_class) { Episodes::Creator }

    service_oriented_action
  end

  describe "PUT #update" do
    let(:action) { -> { put :update, id: 1 } }
    let(:service_class) { Episodes::Updater }

    service_oriented_action
  end

  describe 'DELETE #destroy' do
    let(:action) { -> { post :destroy, id: 1 } }
    let(:service_class) { Episodes::Destroyer }

    service_oriented_action
  end
end
