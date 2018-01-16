require 'rails_helper'

RSpec.describe "stulectures/new", type: :view do
  before(:each) do
    assign(:stulecture, Stulecture.new())
  end

  it "renders new stulecture form" do
    render

    assert_select "form[action=?][method=?]", stulectures_path, "post" do
    end
  end
end
