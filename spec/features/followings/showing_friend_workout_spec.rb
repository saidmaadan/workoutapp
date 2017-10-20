require "rails_helper"

RSpec.feature "Showing Friend Workout" do
  before do
    @said = User.create(first_name: "Said",
                        last_name: "Fola",
                        email: "said@example.com",
                        password: "password")

    @wale = User.create(first_name: "Wale",
                        last_name: "Awe",
                        email: "wale@example.com",
                        password: "password")

    @exercise1 = @said.exercises.create(duration_in_min: 74,
                                workout: "My body building activity",
                                workout_date: Date.today)
    @exercise2 = @wale.exercises.create(duration_in_min: 55,
                                workout: "Weight lifting",
                                workout_date: Date.today)
    login_as(@said)

    @following = Friendship.create(user: @said, friend: @wale)
  end

  scenario "shows friend's workout for last 7 days" do
    visit "/"

    click_link "My Lounge"
    click_link @wale.full_name

    expect(page).to have_content(@wale.full_name + "'s Exercises")
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_css("div#chart")
  end

end
