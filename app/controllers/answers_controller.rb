# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      flash.now[:notice] = 'Your answer was successfully created.'
    else
      flash.now[:alert] = 'Something went wrong'
    end
    # @answer = current_user.answers.create(answer_params.merge(question_id: question.id))
  end

  def update
    answer.update(answer_params)
    # if answer.update(answer_params)
    #   redirect_to answer
    # else
    #   render 'questions/show'
    # end
    @question = answer.question
  end

  def destroy
    @question = answer.question
    if current_user.author_of?(answer)
      answer.destroy
      flash.now[:alert] = 'Answer was deleted.'
    end
  end

  private

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : nil
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
  end

  helper_method :question, :answer

  def answer_params
    params.require(:answer).permit(:body)
  end
end
