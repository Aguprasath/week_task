class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :name,length: {minimum: 3}
end

