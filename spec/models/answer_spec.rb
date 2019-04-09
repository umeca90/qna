require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :author }
  it { should validate_presence_of :body }

  describe '#scope sort_by_best' do
    let(:user) { create :user }
    let!(:question) { create :question, author: user }
    let!(:answer) { create :answer, question: question, author: user }
    let!(:answer1) { create :answer, question: question, author: user }

    it 'sets the best answer attribute' do
      answer.set_the_best

      expect(answer).to be_best
    end

    it 'verifies that only 1 answer has best attribute' do
      answer.set_the_best

      expect(answer1).to_not be_best
    end

    it 'shows the best answer first' do
      answer1.set_the_best

      expect(Answer.all.sort_by_best.first).to eq answer1
    end
  end
end
