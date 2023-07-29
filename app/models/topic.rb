class Topic < ApplicationRecord
  validates :title,:content ,length: { minimum: 5 }
  has_many :posts, dependent: :destroy
end
