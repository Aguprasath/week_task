class Rating < ApplicationRecord
  belongs_to :post, counter_cache: true
  after_create :update_post_rating_average

  private

  def update_post_rating_average
    post.update_rating_average
  end

end
