require 'rails_helper'

feature 'User sign up', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign up
} do
  scenario 'Registered user try to sign up' do
    sign_in create(:user)
    visit new_user_registration_path

    expect(page).to have_content 'You are already signed in.'
    expect(page).to have_content 'Sign out'
    expect(current_path).to eq root_path
  end

  scenario 'Non-Registered user try to sign up (valid data)' do

    visit new_user_registration_path

    data = attributes_for(:user)

    within '#new_user' do
      fill_in 'Email', with: data[:email]
      fill_in 'Password', with: data[:password]
      fill_in 'Password confirmation', with: data[:password_confirmation]
      click_button 'Sign up'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'Sign out'
  end

  scenario 'Non-Registered user try to sign up (invalid data)' do

    visit new_user_registration_path

    data = attributes_for(:user)

    within '#new_user' do
      fill_in 'Email', with: "skjdf"
      fill_in 'Password', with: data[:password]
      fill_in 'Password confirmation', with: data[:password_confirmation]
      click_button 'Sign up'
    end
    expect(page).to have_content 'Sign up'
  end
end