require_relative '../../../spec/acceptance/acceptance_helper'
feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:other_question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:other_answer) { create(:answer, question: other_question, user: other_user) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  context 'Authenticated user' do
    before do
      sign_in user

    end

    scenario 'sees link to Edit' do
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his answer', js: true do
      visit question_path(question)
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario "try to edit other user's question" do
      visit question_path(other_question)
      create(:answer, question: other_question, user: other_user)

      within '.answers' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end

end