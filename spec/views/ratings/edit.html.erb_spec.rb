require 'rails_helper'

RSpec.describe "ratings/edit", type: :view do
  let(:rating) {
    Rating.create!(
      star: 1,
      post: nil
    )
  }

  before(:each) do
    assign(:rating, rating)
  end

  it "renders the edit rating form" do
    render

    assert_select "form[action=?][method=?]", rating_path(rating), "post" do

      assert_select "input[name=?]", "rating[star]"

      assert_select "input[name=?]", "rating[post_id]"
    end
  end
end
