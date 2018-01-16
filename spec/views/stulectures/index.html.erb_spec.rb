require 'rails_helper'

RSpec.describe "stulectures/index", type: :view do
  before(:each) do
    assign(:stulectures, [
      Stulecture.create!(),
      Stulecture.create!()
    ])
  end

  it "renders a list of stulectures" do
    render
  end
end
