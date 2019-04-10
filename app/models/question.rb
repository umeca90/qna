# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many_attached :files, dependent: :destroy
  belongs_to :author, class_name: 'User'
  
  validates :title, :body, presence: true
end
