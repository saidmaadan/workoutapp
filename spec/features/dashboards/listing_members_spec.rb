require "rails_helper"

RSpec.feature "Listing Members" do
  before do
    @said = User.create(first_name: 'Said2', last_name: "Fola4", email: "s3@example.me", password: "password")
    @wale = User.create(first_name: 'Wale5', last_name: "Ola", email: "wale@example.me", password: "password")
  end

  scenario "shows a list of registered members" do
    visit "/"

    expect(page).to have_content("List of Member")
    expect(page).to have_content(@said.full_name)
    expect(page).to have_content(@wale.full_name)
  end
end
