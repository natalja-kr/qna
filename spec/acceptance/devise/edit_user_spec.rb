require 'rails_helper'

feature 'User edit profile', %q{
  In order to be able to change my information
  As an user
  I want to be able to edit profile
} do
  given(:user) {create(:user)}
  scenario 'Registered user try to edit profile with valid data' do

    sign_in(user)
    visit edit_user_registration_path
    data = attributes_for(:user)
      fill_in 'Email', with: data[:email]
      fill_in 'Current password', with: user.password
      click_button 'Update'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Your account has been updated successfully.'
  end

  scenario 'Registered user try to edit profile with invalid data' do
    sign_in(user)
    visit edit_user_registration_path

    data = attributes_for(:user)

      fill_in 'Email', with: "skjdf"
      fill_in 'Password', with: data[:password]
      fill_in 'Password confirmation', with: data[:password_confirmation]
      click_button 'Update'

    expect(page).to have_content 'Edit User'
  end
end