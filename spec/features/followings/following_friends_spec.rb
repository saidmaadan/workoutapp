require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @said = User.create(first_name: "Said",
                        last_name: "Fola",
                        email: "said@example.com",
                        password: "password")

    @stephen = User.create(first_name: "Stephen",
                        last_name: "Byran",
                        email: "stephen@example.com",
                        password: "password")
    login_as(@said)
  end

  scenario "if signed in" do
    visit "/"

    expect(page).to have_content(@said.full_name)
    expect(page).to have_content(@stephen.full_name)

    href = "/friendships?friend_id=#{@said.id}"
    expect(page).not_to have_link("Follow", :href => href)

    link = "a[href='/friendships?friend_id=#{@stephen.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@stephen.id}"
    expect(page).not_to have_link("Follow", :href => href)
  end

end
