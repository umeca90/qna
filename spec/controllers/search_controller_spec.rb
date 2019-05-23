require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let!(:question) { create(:question, body: 'question') }
  let!(:answer) { create(:answer, body: 'answer', question: question) }
  let!(:comment) { create(:question, body: 'comment') }

  describe 'GET #search' do
    before { get :search, params: { query: 'text' } }

    it 'renders template' do
      expect(response).to render_template :search
    end

    it 'assigns @data' do
      expect(assigns(:data)).to be_kind_of(ThinkingSphinx::Search)
    end
  end
end