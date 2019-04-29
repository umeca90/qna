class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    render json: questions, each_serializer: QuestionsSerializer
  end

  def show
    render json: question
  end

  private

  def questions
    @questions ||= Question.all
  end

  def question
    @question ||= Question.find(params[:id])
  end
end