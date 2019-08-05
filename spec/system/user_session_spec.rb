require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  it "signs user in and out" do
    user = create(:user)
    visit new_user_session_path 
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'    
    expect(page).to have_content "Signed in successfully."
    
    click_link('Logout')
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end
