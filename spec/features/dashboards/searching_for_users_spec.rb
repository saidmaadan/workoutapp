require "rails_helper"

RSpec.feature "Searching for User" do
 before do
   @said = User.create!(first_name: "Said",
                        last_name: "Fola",
                        email: "said@example.com",
                        password: "password")

   @wale = User.create!(first_name: "Wale",
                         last_name: "Fola",
                         email: "wale@example.com",
                         password: "password")
 end

 scenario "with existing name returns all those users" do
   visit '/'

   fill_in "search_name", with: "Fola"
   click_button "Search"

   expect(page).to have_content(@said.full_name)
   expect(page).to have_content(@wale.full_name)
   expect(current_path).to eq("/dashboards/search")
 end

end
