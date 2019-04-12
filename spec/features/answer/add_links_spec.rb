require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my question
  As an question's author
  I'd to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:gist_url_1) { "https://gist.github.com/umeca90/e78cf4488daf5cd37d098b790879d405" }
  given(:gist_url_2) { "https://gist.github.com/handofthecode/f3cd43c77c826a5f8d4071969a2c9708" }
  given(:invlaid_url) { "invalid,com" }

  describe 'Aunthenticated user able to', js: true do
    background do
      sign_in(user)
      visit question_path(question)
      fill_in 'Answer body', with: 'text text'
    end

    scenario 'adds links when creates an answer', js: true do
      within("#answer-links") do
        fill_in 'Link name', with: 'My gist1'
        fill_in 'Url', with: gist_url_1
        click_on 'additional link'
      end

      within all('.nested-fields')[1] do
        fill_in 'Link name', with: 'My gist2'
        fill_in 'Url', with: gist_url_2
      end

      click_on 'Create answer'

      within('.answers') do
        expect(page).to have_link 'My gist1', href: gist_url_1
        expect(page).to have_link 'My gist2', href: gist_url_2
      end
    end

    scenario 'adds invalid links when creates an answer', js: true do
      within("#answer-links") do
        fill_in 'Link name', with: 'My gist1'
        fill_in 'Url', with: invlaid_url
        click_on 'additional link'
      end
      click_on 'Create answer'

      within('.answers') do
        expect(page).to have_content 'Links url is not a valid URL'
      end
    end
  end

  scenario 'Ununthenticated user cannot add links when creates an answer' do
    visit question_path(question)
    expect(page).not_to have_link 'Add link'
  end
end
