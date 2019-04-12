require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { "https://gist.github.com/umeca90/e78cf4488daf5cd37d098b790879d405" }

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: :title
    fill_in 'Body', with: :body

    fill_in 'Link', with: 'Link name'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'Link name', href: gist_url
  end

end