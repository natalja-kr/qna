require 'rails_helper'

feature 'User sign out', %q{
  In order to be able to maintain confidentiality
  As an user
  I want to be able to sign out
} do
  given(:user) {create(:user)}
  scenario 'Registered user try to sign out' do
    sign_in(user)

    page.driver.submit :delete, "/users/sign_out", {}

    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content 'Sign in'
    expect(current_path).to eq root_path
  end
end