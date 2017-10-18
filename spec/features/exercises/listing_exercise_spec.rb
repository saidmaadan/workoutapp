require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @user = User.create!(email: "said@example.com", password: "password")
    login_as(@user)

    @e1 = @user.exercises.create(duration_in_min: 20,
                                  workout: "My ABS workout schedule",
                                  workout_date: Date.today)

    @e2 = @user.exercises.create(duration_in_min: 55,
                                  workout: "Pree Up",
                                  workout_date: 2.days.ago)


  end

  scenario "shows user's workout for last 7 days" do
    visit '/'

    click_link "My Lounge"

    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)

    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)

    # expect(page).not_to have_content(@e3.duration_in_min)
    # expect(page).not_to have_content(@e3.workout)
    # expect(page).not_to have_content(@e3.workout_date)

  end
end
