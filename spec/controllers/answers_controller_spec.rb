require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 3, question: question) }
    before { get :index, params: { question_id: question } }

    it 'populates an array of answers of certain question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'renders new view' do
      get :new, params: { question_id: question }
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:answer) { create :answer, question: question }
    it 'returns edit view' do
      get :edit, params: { id: answer }
      expect(response).to render_template :edit
    end
  end
end
