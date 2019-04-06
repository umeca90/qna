require 'rails_helper'

feature 'User can create an answer', %q{
  In order to help other users
  As an authenticated User
  I'd like to be able to ask the question
  } do

    given(:user) { create(:user) }
    given(:question) { create(:question) }

    describe 'Authenticated user' do
      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'create an answer' do
        fill_in 'Body', with: 'text body'
        click_on 'Create answer'

        expect(page).to have_content 'Your answer was successfully created.'
        expect(page).to have_content 'text body'
      end

      scenario 'create invalid answer' do
        click_on 'Create answer'

        expect(page).to have_content "Body can't be blank"
      end
    end

    scenario 'Unauthenticated user tries to ask a question' do
      visit question_path(question)
      fill_in 'Body', with: 'Text text text'
      click_on 'Create answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
