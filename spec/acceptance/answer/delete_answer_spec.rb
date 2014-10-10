require 'acceptance/acceptance_helper'

feature 'Delete answer', %q{
  When I created not the right answer
  As an authenticated user
  I want to be able to delete answer
} do

  given(:user) {create(:user)}
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user, question: question) }

  scenario 'Owner delete answer' do

    sign_in(user)

    visit question_path(question)
    within '.answers' do
      click_on 'Delete'
    end


    expect(current_path).to eq questions_path
    expect(page).to have_content 'Your answer successfully delete.'
    expect(page).to_not have_content answer.body
  end

  scenario "The user removes the opponent's answer" do
    sign_in(user)
    new_answer = create(:answer, question: question, user: create(:user))
    visit question_path(question)
    within '.answers' do
      expect(page).not_to have_link 'Delete'
    end
  end

end