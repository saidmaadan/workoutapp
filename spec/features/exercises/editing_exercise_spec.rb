require 'rails_helper'

RSpec.feature "Editing Exercise" do
  before do
    @owner = User.create!(first_name: "Said", last_name: "Fola", email: "owner@example.com", password: "password")

    @owner_exercise = @owner.exercises.create!(duration_in_min: 65,
                                                workout: "My body building activity",
                                                workout_date: Date.today)

    login_as(@owner)
  end

  scenario "with valid data succeeds" do
    visit '/'

    click_link "My Lounge"

    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click

    fill_in "Duration", with: 75
    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(75)
    expect(page).not_to have_content(65)
  end
end
