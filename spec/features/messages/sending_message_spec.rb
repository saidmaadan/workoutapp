require "rails_helper"

RSpec.feature "Sending a message" do
  before do
    @said = User.create!(first_name: 'Said', last_name: 'Fola', email: 'said@example.com', password: 'password')
    @wale = User.create!(first_name: 'Wale', last_name: 'Awe', email: 'wale@example.com', password: 'password')
    @adeola = User.create!(first_name: 'Adeola', last_name: 'Abiola', email: 'adeola@example.com', password: 'password')

    @room_name = @said.first_name + '-' + @said.last_name
    @room = Room.create!(name: @room_name, user_id: @said.id)

    login_as(@said)

    Friendship.create(user: @wale, friend: @said)
    Friendship.create(user: @adeola, friend: @said)
  end

  scenario "to followers shows in chatroom window" do
    visit '/'

    click_link "My Lounge"
    expect(page).to have_content(@room_name)

    fill_in "message-field", with: "Hello"
    click_button "Post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@wale.full_name)
      expect(page).to have_link(@adeola.full_name)
    end
  end

end
