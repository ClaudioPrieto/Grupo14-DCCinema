=begin
require 'rails_helper'

RSpec.describe "movie_instances/edit", type: :view do
  before(:each) do
    @movie_instance = assign(:movie_instance, MovieInstance.create!(
      movie_id: 1,
      room_id: 1,
      schedule: "MyString"
    ))
  end

  it "renders the edit movie_instance form" do
    render

    assert_select "form[action=?][method=?]", movie_instance_path(@movie_instance), "post" do

      assert_select "input[name=?]", "movie_instance[movie_id]"

      assert_select "input[name=?]", "movie_instance[room_id]"

      assert_select "input[name=?]", "movie_instance[schedule]"
    end
  end
end
=end