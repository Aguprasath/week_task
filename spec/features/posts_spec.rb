require 'rails_helper'

RSpec.feature 'Posts Pagination' ,type: :feature do
  let(:topic) { Topic.create(title: "The God", content: "content about gods") }

  before do
    # Create some sample posts for testing pagination
    25.times { |n| topic.posts.create(title: "Post #{n}", content: "Post content #{n}") }
  end

  it "displays 10 posts per page" do
    visit topic_posts_path(topic)
    expect(page).to have_selector(".post", count: 10)
    expect(page).to have_selector(".pagination")
    expect(page).to have_selector(".pagination .page", count: 3) # Since we have 25 posts and 10 posts per page, there should be 3 pages
  end
end