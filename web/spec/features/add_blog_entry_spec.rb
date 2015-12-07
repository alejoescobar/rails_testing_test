require 'rails_helper'
RSpec.feature 'adding blog entries' do

  scenario 'allow a user to add a blog entry' do
    visit new_blog_entry_path

    fill_in 'Title', with: 'My Title'
    fill_in 'Content', with: 'My Content'

    click_on('Create Blog entry')

    expect(page).to have_content("My Title")
    expect(page).to have_content("My Content")

  end

end