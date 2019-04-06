# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @answers = question.answers
  end

  def new; end

  def edit; end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to question, notice: 'Your answer was successfully created.'
    else
      render 'questions/show'
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to answer
    else
      render 'questions/show'
    end
  end

  def destroy
    if answer.destroy && current_user.author_of?(answer)
      redirect_to answer.question, notice: 'Answer was deleted.'
    else
      render 'questions/show', notice: 'Something went wrong.'
    end
  end

  private

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : nil
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answer.new
  end

  helper_method :question, :answer

  def answer_params
    params.require(:answer).permit(:body)
  end
end
