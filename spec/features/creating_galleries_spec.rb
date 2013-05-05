require 'spec_helper'

feature 'Creating Photos' do 
  
  before do 
    # user = Factory(:user) 
    user.confirm!
    sign_in_as!(user)
    visit root_path
    click_link "New Gallery"
  end
  scenario 'can create a gallery' do 

    fill_in 'Name', with: 'Last vacation'
    fill_in "Description",  with: 'nice photos of last vacation'
    click_button 'Create Gallery'
    expect(page).to have_content('Gallery has been created.')

    gallery = Gallery.where(name: "Last vacation").first
    expect(page.current_url).to eql(gallery_url(gallery))

    title = "Last vacation - Galleries"
    expect(page).to have_title(title)
  end

  scenario "can not create a gallery without a name" do 
    visit root_path
    click_link "New Gallery"
    click_button "Create Gallery"

    expect(page).to have_content("Gallery has not been created.")
    expect(page).to have_content("can't be blank")
  end
end