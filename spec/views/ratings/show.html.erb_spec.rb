require 'rails_helper'

RSpec.describe "ratings/show", type: :view do
  before(:each) do
    assign(:rating, Rating.create!(
      star: 2,
      post: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
