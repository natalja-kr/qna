require 'rails_helper'

feature 'Delete question', %q{
  When I created not the right question
  As an authenticated user
  I want to be able to delete question
} do

  given(:user) {create(:user)}
  given(:question) { create(:question, user: user) }

  scenario 'Owner delete question' do

    sign_in(user)

    visit question_path(question)
    click_on 'Delete this my question'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Your question successfully delete.'
  end

  scenario "The user removes the opponent's question" do
    visit question_path(question)

    expect(page).not_to have_link 'Delete this my question'
  end

end