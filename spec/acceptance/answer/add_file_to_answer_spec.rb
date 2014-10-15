require 'acceptance/acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user){ create(:user) }
  given(:question){ create(:question) }
  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds files when ask question', js: true do
    fill_in 'Your answer', with: 'My answer'
    click_on 'Add a attachment'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Add a attachment'

    fields = all('.fields')

    within fields[1] do

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end
    click_on 'Create'
    within '.answers' do
      expect(page) .to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end

end