# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_many_attached :files, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank

  belongs_to :author, class_name: 'User'
  
  validates :title, :body, presence: true
end
