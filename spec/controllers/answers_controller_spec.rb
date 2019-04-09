# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer into database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question },format: :js }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question' do
        post :create, params: {  question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end

      it 'verifies if user is the author' do
        post :create, params: {  question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(assigns(:answer).author).to eq user
      end
    end

    context 'with ivalid attributes' do
      it 'does not save answer into database' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }, format: :js }.to_not change(Answer, :count)
      end

      it 're-renders create' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:answer) { create(:answer, question: question, author: user) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :edit_body) }, format: :js
        answer.reload

        expect(answer.body).to eq 'New body'
      end

      it 'renders updates view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js }

      it 'does not change answer' do
        answer.reload

        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)

      end

      it 're-renders update template' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user1) { create :user }
    let!(:answer) { create :answer, question: question, author: user1 }

    context 'Author of the question' do
      before { login(user1) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer },format: :js }.to change(question.answers, :count).by(-1)
      end

      it 'renders destroy template' do
        delete :destroy, params: { id: answer },format: :js

        expect(response).to render_template :destroy
      end
    end

    context 'Not author' do
      before { login(user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer }, format: :js }.to_not change(Answer, :count)
      end

      it 'renders destroy template' do
        delete :destroy, params: { id: answer }, format: :js

        expect(response).to render_template :destroy
      end
    end

    context 'Unauthenticated user' do
      it 'tries to delete an answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to login' do
        delete :destroy, params: { id: answer }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
