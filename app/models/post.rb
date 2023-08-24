class Post < ApplicationRecord
  validates :title,:content ,length: { minimum: 5 }
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings, dependent: :destroy
  has_one_attached :image
  has_and_belongs_to_many :read_by_users, class_name: 'User', join_table: :posts_users_read_statuses

  belongs_to :user
  def average_rating
    return 0 if ratings.empty?
    ratings.average(:star).truncate(1)
  end
   def comment_count
      return 0 if comments.empty?
      comments.count
   end
end
