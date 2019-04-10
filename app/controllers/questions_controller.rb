# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :questions_author!, only: %i[update destroy]

  def index
    @questions = Question.all
  end

  def show; end

  def new; end

  def edit; end

  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    question.update(question_params)
    flash.now[:notice] = 'Question was updated.'
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: 'Question was deleted.'
  end

  private

  def questions_author!
    head :forbidden unless current_user&.author_of?(question)
  end

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  def answer
    @answer = question.answers.new
  end

  helper_method :question, :answer

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end
end
