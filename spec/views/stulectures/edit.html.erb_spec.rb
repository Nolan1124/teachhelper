require 'rails_helper'

RSpec.describe "stulectures/edit", type: :view do
  before(:each) do
    @stulecture = assign(:stulecture, Stulecture.create!())
  end

  it "renders the edit stulecture form" do
    render

    assert_select "form[action=?][method=?]", stulecture_path(@stulecture), "post" do
    end
  end
end
