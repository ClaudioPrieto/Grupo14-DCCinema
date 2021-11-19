=begin
require 'rails_helper'

RSpec.describe "movie_instances/new", type: :view do
  before(:each) do
    assign(:movie_instance, MovieInstance.new(
      movie_id: 1,
      room_id: 1,
      schedule: "MyString"
    ))
  end

  it "renders new movie_instance form" do
    render

    assert_select "form[action=?][method=?]", movie_instances_path, "post" do

      assert_select "input[name=?]", "movie_instance[movie_id]"

      assert_select "input[name=?]", "movie_instance[room_id]"

      assert_select "input[name=?]", "movie_instance[schedule]"
    end
  end
end
=end
