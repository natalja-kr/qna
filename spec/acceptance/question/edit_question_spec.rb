require 'rails_helper'

feature 'Edit question', %q{
  When I created not the right question
  As an authenticated user
  I want to be able to edit question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Owner edit question with valid data' do

    sign_in(user)

    visit question_path(question)
    click_on 'Edit'

    expect(current_path).to eq edit_question_path(question)

    fill_in 'Title', with: "Test question Test question"
    fill_in 'Body', with: "skjksdhfhskfks dksdjkskhds ds dskjdssk"
    click_on 'Update'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Your question successfully update.'
  end

  scenario 'Owner edit question with invalid data' do

    sign_in(user)

    visit question_path(question)
    click_on 'Edit'

    expect(current_path).to eq edit_question_path(question)

    fill_in 'Title', with: ""
    fill_in 'Body', with: ""
    click_on 'Update'

    expect(page).to have_content 'You have entered incorrect data.'
  end

  scenario "The user update the opponent's question" do
    visit question_path(question)

    expect(page).not_to have_link 'Edit'
  end

end