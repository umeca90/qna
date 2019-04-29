class Api::V1::AnswersController < Api::V1::BaseController
  def index
    render json: answers, each_serialized: AnswersSerializer
  end

  def show
    render json: answer
  end

  private

  def answers
    @answers ||= Answer.all
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end
end