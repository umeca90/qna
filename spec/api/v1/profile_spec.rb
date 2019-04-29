require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json" } }

  describe 'GET /api/v1/profiles/me' do
    it_behaves_like 'API Authorizable' do
      let(:api_path) { '/api/v1/profiles/me' }
      let(:method) { :get }
    end

    context 'authorized' do
      let(:me) { create :user }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'reterns all public fields' do
        %w[id email admin created_at updated_at].each do |attr|
          expect(json['user'][attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end

  describe 'GET /api/v1/profiles/' do
    it_behaves_like 'API Authorizable' do
      let(:api_path) { '/api/v1/profiles/' }
      let(:method) { :get }
    end

    context 'authorized' do
      let(:me) { create :user }
      let!(:users) { create_list(:user, 3) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:user_response) { json['users'].first }
      let(:user) { users.first }

      before { get '/api/v1/profiles/', params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns list with users profiles except current_user' do
        expect(json['users'].size).to eq 3
      end

      it 'reterns all public fields' do
        %w[id email admin created_at updated_at].each do |attr|
          expect(user_response[attr]).to eq user.send(attr).as_json
        end
      end

    end
  end
end