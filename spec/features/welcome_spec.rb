require 'rails_helper'

RSpec.describe 'welcome page' do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:user_2) { User.create!(name: "Hank", email: "hank@zmail.com", password: "password" ) } 
  let!(:user_3) { User.create!(name: "Tom", email: "tom@zmail.com", password: "password") }

  it 'has title of application' do 
    visit root_path

    expect(page).to have_content("Viewing Party")
  end

  it 'has button to navegate to user registration' do 
    visit root_path

    click_button "Register"

    expect(current_path).to eq(registration_path)
  end

  it 'has list of existing users that link to user dashboard page' do 
    visit root_path 

    expect(page).to have_content(user_1.name)
    expect(page).to have_content(user_2.name)
    expect(page).to have_content(user_3.name)

    click_link user_1.name 

    expect(current_path).to eq("/users/#{user_1.id}")
  end

  it 'has link to landing page' do 
    visit root_path 

    click_link "Back to the Welcome Page"

    expect(current_path).to eq(root_path)
  end

  it 'has link to log in' do 
    visit root_path 

    click_link "Log In"
    
    expect(current_path).to eq('/login')
  end
end