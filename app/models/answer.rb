# frozen_string_literal: true

class Answer < ApplicationRecord

  include FilesAttachable
  include LinksAttachable
  include Votable
  include Commentable

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  after_create :notify_questions_author

  scope :sort_by_best, -> { order(best: :desc) }

  def set_the_best
    self.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
      question.award&.update!(user: author)
    end
  end

  private

  def notify_questions_author
    NewAnswerNotifierMailer.notify_about_new_answer(self).deliver_later
  end
end
