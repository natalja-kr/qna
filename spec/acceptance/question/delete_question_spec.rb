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
    click_on 'Delete'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Your question successfully delete.'
    #not question
  end

  scenario "The user removes the opponent's question" do
    sign_in(user)
    new_question = create(:question, user: create(:user))
    visit question_path(new_question)

    expect(page).not_to have_link 'Delete'
  end

end