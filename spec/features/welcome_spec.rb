require 'rails_helper'

RSpec.describe 'welcome page' do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:user_2) { User.create!(name: "Hank", email: "hank@zmail.com", password: "password" ) } 
  let!(:user_3) { User.create!(name: "Tom", email: "tom@zmail.com", password: "password") }

  it 'has title of application' do 
    visit root_path

    expect(page).to have_content("Viewing Party")
  end

  it 'has button to register if no session is active' do 
    visit root_path

    expect(page).to_not have_content("Log Out")

    click_button "Register"

    expect(current_path).to eq(registration_path)
  end

  it 'has link to log in if no session is active' do 
    visit root_path 

    expect(page).to_not have_content("Log Out")
    
    click_link "Log In"
    
    expect(current_path).to eq(login_path)
  end

  it 'has link to log out and no link to register or log in if session is active' do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit root_path 

    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Register")

    click_button "Log Out"

    expect(current_path).to eq(root_path)
  end

  it 'has list of existing users if a session is active' do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit root_path 
  
    expect(page).to have_content(user_1.email)
    expect(page).to have_content(user_2.email)
    expect(page).to have_content(user_3.email)
  end 

  it 'doesnt have list of existing users if a session is not active' do 
    visit root_path 
  
    expect(page).to_not have_content(user_1.email)
    expect(page).to_not have_content(user_2.email)
    expect(page).to_not have_content(user_3.email)
  end
  
  it 'has link to landing page' do 
    visit root_path 
  
    click_link "Back to the Welcome Page"
  
    expect(current_path).to eq(root_path)
  end

  it 'doesnt let you navegate to dashboard id no session is active' do 
    visit root_path 

    visit '/dashboard'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in to view the dashboard.")
  end
end