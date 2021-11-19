=begin
require 'rails_helper'

RSpec.describe "movies/index", type: :view do
  before(:each) do
    assign(:movies, [
      Movie.create!(
        name: "Name",
        image: "Image"
      ),
      Movie.create!(
        name: "Name",
        image: "Image"
      )
    ])
  end
"""
  it "renders a list of movies" do
    render
    assert_select "p", text: "Name".to_s, count: 2
    assert_select "p", text: "Image".to_s, count: 2
  end

end
=end
