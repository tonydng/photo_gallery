require 'spec_helper'

feature 'Creating Galleries' do 
  scenario 'can create a gallery' do 
    visit root_path
    click_link "New Gallery"
    fill_in 'Name', with: 'Last vacation'
    fill_in "Description",  with: 'nice photos of last vacation'
    click_button 'Create Gallery'
    expect(page).to have_content('Gallery has been created.')
  end
end