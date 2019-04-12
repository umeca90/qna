require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url_1) { "https://gist.github.com/umeca90/e78cf4488daf5cd37d098b790879d405" }
  given(:gist_url_2) { "https://gist.github.com/handofthecode/f3cd43c77c826a5f8d4071969a2c9708" }
  given(:invlaid_url) { "invalid,com" }

  describe 'Aunthenticated user', js: true do
    background do
      sign_in(user)
      visit new_question_path

      fill_in 'Title', with: :title
      fill_in 'Body', with: :body
    end

    scenario 'can add several links when asks a question' do
      within('#question-links') do
        fill_in 'Link', with: 'Link name'
        fill_in 'Url', with: gist_url_1

        click_on 'add link'
      end

      within all(".nested-fields")[1] do
        fill_in 'Link', with: 'Link name'
        fill_in 'Url', with: gist_url_2
      end

      click_on 'Ask'

      within('.question') do
        expect(page).to have_link 'Link name', href: gist_url_1
        expect(page).to have_link 'Link name', href: gist_url_2
      end
    end

    scenario 'adds invalid links when asks question', js: true do
      within("#question-links") do
        fill_in 'Link name', with: 'My gist1'
        fill_in 'Url', with: invlaid_url
        click_on 'add link'
      end
      click_on 'Ask'

      expect(page).to have_content 'Links url is not a valid URL'
    end
  end



  scenario 'Ununthenticated user cannot add links when asks question' do
    visit new_question_path
    expect(page).not_to have_link 'Add link'
  end

end