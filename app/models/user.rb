class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :answers, foreign_key: 'author_id', dependent: :destroy
  has_many :questions, foreign_key: 'author_id', dependent: :destroy

  def author_of?(object)
    object.author_id == id
  end
  
end