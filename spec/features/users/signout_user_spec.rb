require "rails_helper"

RSpec.feature "Users signin" do
  before do
    @user = User.create!(email: "said@example.com", password: "password")
  end

  # scenario "with valid credentials" do
  #   visit '/'
  #
  #   click_link "Sign out"
  #
  #   fill_in "Email", with: "@user.email"
  #   fill_in "Password", with: "@user.password"
  #
  #   click_button "Log in"
  #
  #   expect(page).to have_content("You have signed up successfully.")
  #   expect(page).to have_content("#{@user.email}")
  #
  # end
end
