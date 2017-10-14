require "rails_helper"

RSpec.feature "Creating Home Page" do
  scenario do
    visit '/'

    expect(page).to have_link("Home")
    expect(page).to have_link("Athletes De")
    expect(page).to have_link("Workout Lounge")
    expect(page).to have_link("Show off your workout")
  end
end
