class Api::V1::AnswersController < Api::V1::BaseController
  def index
    render json: answers, each_serialized: AnswersSerializer
  end

  def show
    render json: answer
  end

  def create
    answer = question.answers.build(answer_params)
    answer.author = current_resource_owner

    if answer.save
      render json: answer, status: :created
    else
      render json: answer.errors, status: :unprocessable_entity
    end
  end

  private

  def answers
    @answers ||= Answer.all
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end