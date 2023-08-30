class Comment < ApplicationRecord
  belongs_to :post
  validates :content,length: {minimum: 4}
  belongs_to :user
  has_many :user_comment_ratings
  has_many :users, through: :user_comment_ratings
end
