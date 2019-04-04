class AnswersController < ApplicationController
  def index
    @answers = question.answers
  end

  def new; end

  # def create
  #   @answer = question.answer.new(answer_params)
  # end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  # def answer
  #   @answer = params[:id] ? Answer.find(params[:id]) : Answer.new
  # end
  #
  # helper_method :question, :answer
  #
  # def answer_params
  #   params.require(:answer).permit(:body)
  # end
end
