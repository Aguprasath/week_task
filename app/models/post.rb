class Post < ApplicationRecord
  validates :title,:content ,length: { minimum: 5 }
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings, dependent: :destroy
end
