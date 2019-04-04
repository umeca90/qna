class AnswersController < ApplicationController
  def index
    @answers = question.answers
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end
end
