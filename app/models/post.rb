class Post < ApplicationRecord
  validates :title,:content ,length: { minimum: 5 }
  belongs_to :topic
end
