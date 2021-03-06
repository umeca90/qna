# frozen_string_literal: true

class Question < ApplicationRecord

  include FilesAttachable
  include LinksAttachable
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_one :award, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  accepts_nested_attributes_for :award, reject_if: :all_blank

  belongs_to :author, class_name: 'User'
  validates :title, :body, presence: true

  after_create :calculate_reputation, :subscribe_author

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end

  def subscribe_author
    subscriptions.create(user: author)
  end
end
