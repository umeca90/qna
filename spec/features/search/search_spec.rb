# frozen_string_literal: true

require 'sphinx_helper'

feature 'User can access search engine', %q{
  In order to faster access interested information
  As user
  I'd like to be able to have access to search engine
} do
  given!(:user) { create(:user, email: 'test1@mail.net') }
  given!(:question) { create(:question, body: 'some question') }
  given!(:answer)   { create(:answer,   body: 'some answer', question: question) }
  given!(:comment) { create(:question_comment, body: 'some comment', commentable: question) }

  background do
    visit root_path
  end

  scenario 'Searches thru all models', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      click_on 'Find'

      within '.result-search' do
        expect(page).to have_content 'some question'
        expect(page).to have_content 'some answer'
        expect(page).to have_content 'some comment'
        expect(page).to have_content 'test1@mail.net'
      end
    end
  end

  scenario 'Searches thru questions', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'question'
      check 'Question'
      click_on 'Find'

      sleep 2

      within '.result-search' do
        expect(page).to have_content 'some question'
      end
    end
  end

  scenario 'Searches thru answers', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'answer'
      check 'Answer'
      click_on 'Find'

      within '.result-search' do
        expect(page).to have_content 'some answer'
      end
    end
  end

  scenario 'Searches thru comments', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'comment'
      check 'Comment'
      click_on 'Find'

      within '.result-search' do
        expect(page).to have_content 'some comment'
      end
    end
  end

  scenario 'Searches thru users', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'test1'
      check 'User'
      click_on 'Find'

      within '.result-search' do
        expect(page).to have_content 'test1@mail.net'
      end
    end
  end

  scenario 'No result', sphinx: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'none'
      check 'User'
      click_on 'Find'

      within '.result-search' do
        expect(page).to_not have_content 'none'
      end
    end
  end
end
