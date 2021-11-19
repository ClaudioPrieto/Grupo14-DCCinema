=begin
require 'rails_helper'

RSpec.describe "movie_instances/show", type: :view do
  before(:each) do
    @movie_instance = assign(:movie_instance, MovieInstance.create!(
      movie_id: 2,
      room_id: 3,
      schedule: "Schedule"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Schedule/)
  end
end
=end
