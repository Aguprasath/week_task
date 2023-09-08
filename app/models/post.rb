class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings, dependent: :destroy
  has_one_attached :image
  has_and_belongs_to_many :read_by_users, class_name: 'User', join_table: :posts_users_read_statuses

  belongs_to :user

  scope :filter_by_date,->(start_date,to_date){ (where "Date(posts.created_at) >=? and Date(posts.created_at)<=?",start_date,to_date) }
  # def average_rating
  #   return 0 if ratings.empty?
  #   ratings.average(:star).truncate(1)
  # end
   # def comment_count
   #    return 0 if comments.empty?
   #    comments.count
   # end
  def update_rating_average
    new_average = ratings.average(:star)
    update_column(:rating_average, new_average)
  end

end
