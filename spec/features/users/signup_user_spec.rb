require "rails_helper"

RSpec.feature "Signup Users" do
  scenario "with valid credentials" do
    visit '/'

    click_link "Sign up"
    fill_in "First name", with: "Said"
    fill_in "Last name", with: "Fola"
    fill_in "Email", with: "said@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")

    user = User.last
    room = user.room
    room_name = user.full_name.split.join('-')
    expect(room.name).to eq(room_name)

    visit '/'
    expect(page).to have_content("Said Fola")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end
