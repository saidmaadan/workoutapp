require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @user = User.create!(first_name: "Said", last_name: "Fola", email: "said@exercisexample.com", password: "password")
    @kunle = User.create!(first_name: "Kunle", last_name: "Abiola", email: "kunle@exercisexample.com", password: "password")
    login_as(@user)

    @exercise1 = @user.exercises.create(duration_in_min: 20,
                                  workout: "My ABS workout schedule",
                                  workout_date: Date.today)

    @exercise2 = @user.exercises.create(duration_in_min: 55,
                                  workout: "Press Up",
                                  workout_date: 2.days.ago)
    @following = Friendship.create(user: @user, friend: @kunle)
    # @exercise3 = @user.exercises.create(duration_in_min: 40,
    #                               workout: "Run on the hill",
    #                               workout_date: 12.days.ago)


  end

  scenario "shows user's workout for last 7 days" do
    visit '/'

    click_link "My Lounge"

    expect(page).to have_content(@exercise1.duration_in_min)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration_in_min)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    # expect(page).not_to have_content(@exercise3.duration_in_min)
    # expect(page).not_to have_content(@exercise3.workout)
    # expect(page).not_to have_content(@exercise3.workout_date)
  end

  scenario "shows no exercises if none created" do
    @user.exercises.delete_all

    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content('No Workouts Yet')
  end

  scenario "show a list of user'd friends" do
    visit "/"

    click_link "My Lounge"
    expect(page).to have_content("My Friends")
    expect(page).to have_link(@kunle.full_name)
    expect(page).to have_link("Unfollow")
  end
end
