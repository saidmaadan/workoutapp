require "rails_helper"

RSpec.feature "Creating Exercise" do
  before do
    @user = User.create(email: 'said@example.com', password: 'password')
    login_as(@user)
  end

  scenario "with valid inputs" do
    visit '/'

    click_link "My Lounge"
    click_link "New Workout"

    expect(page).to have_link("Back")

    fill_in "Duration", with: 120
    fill_in "Workout details", with: "Press up"
    fill_in "Activity date", with: "2017-09-21"
    click_button 'Create Exercise'

    expect(page).to have_content("Exercise has been created")

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@user, exercise))
    expect(exercise.user_id).to eq(@user.id)

  end
end
