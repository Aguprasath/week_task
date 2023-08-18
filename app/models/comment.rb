class Comment < ApplicationRecord
  belongs_to :post
  validates :content,length: {minimum: 4}
  belongs_to :user
end
