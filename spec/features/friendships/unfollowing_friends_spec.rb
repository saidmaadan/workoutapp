require 'rails_helper'

RSpec.feature "Unfollowing Friend" do
  before do
    @said = User.create(first_name: "Said",
                        last_name: "Fola",
                        email: "said@example.com",
                        password: "password")
    @wale = User.create(first_name: "Wale",
                        last_name: "Awe",
                        email: "wale@example.com",
                        password: "password")
    login_as(@said)

    @following = Friendship.create(user: @said, friend: @wale)
  end

  scenario do
    visit "/"

    click_link "My Lounge"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@wale.full_name + " unfollowed")
  end
end
