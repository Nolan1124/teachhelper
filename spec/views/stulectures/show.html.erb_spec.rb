require 'rails_helper'

RSpec.describe "stulectures/show", type: :view do
  before(:each) do
    @stulecture = assign(:stulecture, Stulecture.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
