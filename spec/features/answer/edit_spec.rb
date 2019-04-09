require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be adble to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unaunthenticated user can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Aunthenticated user' do
    scenario 'edit his answer', js: true do
      sign_in user
      visit question_path(question)

      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: :edit_body
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content :edit_body
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edit his answer'
    scenario "tries to edit other user's question"

  end
end