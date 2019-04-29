require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:question) { create(:question) }
  let(:comment) { create(:comment) }
  let(:user) { create(:user) }
  let(:create_comment) { post :create, params: { comment: attributes_for(:comment),
                                                 question_id: question.id,
                                                 user_id: user.id }, format: :js }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saved a new comment in the db' do
        expect { create_comment }.to change(Comment, :count).by(1)
      end

      it 'user is author' do
        create_comment

        expect(assigns(:comment).author).to eq user
      end
    end

    context 'with invalid attributes' do
      it 'does not save the comment' do
        expect do
          post :create, params: { comment: attributes_for(:comment, :invalid), question_id: question.id }, format: :json
        end.to_not change(Comment, :count)
      end
    end
  end
end