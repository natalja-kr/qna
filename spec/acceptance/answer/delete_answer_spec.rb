require 'acceptance/acceptance_helper'

feature 'Delete answer', %q{
  When I created not the right answer
  As an authenticated user
  I want to be able to delete answer
} do

  given!(:user) {create(:user)}
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Owner delete answer', js: true do

    sign_in(user)

    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to_not have_content answer.body
  end

  scenario "The user removes the opponent's answer" do
    sign_in(user)
    new_question = create(:question, user: user)
    new_answer = create(:answer, question: new_question, user: create(:user))
    visit question_path(new_question)

    expect(page).not_to have_link 'Delete answer'

  end

end