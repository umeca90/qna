require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my question
  As an question's author
  I'd to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:gist_url) { "https://gist.github.com/umeca90/e78cf4488daf5cd37d098b790879d405" }

  scenario 'User adds link when asks answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Answer body', with: 'text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Create answer'

    within('.answers') do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end

end