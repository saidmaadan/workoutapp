require "rails_helper"

RSpec.feature "Showing Friend Workout" do
  before do
    @user = User.create(first_name: "Said",
                        last_name: "Doe",
                        email: "user@example.com",
                        password: "password")

    @sarah = User.create(first_name: "Sarah",
                        last_name: "Anderson",
                        email: "sarah@example.com",
                        password: "password")

    @e1 = @user.exercises.create(duration_in_min: 74,
                                workout: "My body building activity",
                                workout_date: Date.today)
    @e2 = @sarah.exercises.create(duration_in_min: 55,
                                workout: "Weight lifting",
                                workout_date: Date.today)
    login_as(@user)

    @following = Friendship.create(user: @user, friend: @sarah)
  end

  scenario "shows friend's workout for last 7 days" do
    visit "/"

    click_link "My Lounge"
    click_link @sarah.full_name

    expect(page).to have_content(@sarah.full_name + "'s Exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end

end
