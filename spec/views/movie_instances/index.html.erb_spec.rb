=begin
require 'rails_helper'

RSpec.describe "movie_instances/index", type: :view do
  before(:each) do
    assign(:movie_instances, [
      MovieInstance.create!(
        movie_id: 2,
        room_id: 3,
        schedule: "Schedule"
      ),
      MovieInstance.create!(
        movie_id: 2,
        room_id: 3,
        schedule: "Schedule"
      )
    ])
  end

  it "renders a list of movie_instances" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Schedule".to_s, count: 2
  end
end
=end
