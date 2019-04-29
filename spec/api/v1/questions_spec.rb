require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json" } }
  let(:access_token) { create(:access_token) }

  describe 'GET /api/v1/questions' do
    let(:api_path) { '/api/v1/questions/' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:user) { create :user }
      let!(:questions) { create_list(:question, 2, author: user) }
      let(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { create_list(:answer, 3, author: user, question: question) }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it_should_behave_like 'API ok status'

      it 'returns list of questions' do
        expect(json['questions'].size).to eq 2
      end

      it 'reterns all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      it 'contains user object' do
        expect(question_response['author']['id']).to eq question.author.id
      end

      it 'contains short title' do
        expect(question_response['short_title']).to eq question.title.truncate(7)
      end
    end
  end

  describe 'GET /api/v1/questions/:id' do
    let(:question) { create(:question, :with_files, :with_comments, :with_links)}
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:question_response) { json['question'] }
    let(:link) { question.links.first }
    let(:link_response) { question_response['links'].first }
    let(:comment) { question.comments.first }
    let(:comment_response) { question_response['comments'].first }

    before { get api_path, params: { access_token: access_token.token }, headers: headers }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    it_should_behave_like 'API ok status'

    it 'returns all public fiels' do
      %w[id title body created_at updated_at].each do |attr|
        expect(question_response[attr]).to eq question.send(attr).as_json
      end
    end

    it 'returns all public fields with links' do
      %w[id name url linkable_type linkable_id created_at updated_at].each do |attr|
        expect(link_response[attr]).to eq link.send(attr).as_json
      end
    end

    it 'returns files url' do
      expect(question_response['files'].first).to match 'rails_helper.rb'
    end

    it 'returns all public fields with comments' do
      %w[id body commentable_type commentable_id created_at updated_at].each do |attr|
        expect(comment_response[attr]).to eq comment.send(attr).as_json
      end
    end
  end
end