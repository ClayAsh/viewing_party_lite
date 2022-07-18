require 'rails_helper'

RSpec.describe "User Login form" do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password") }

  it 'can check user credentials and log them in' do 
    visit '/login'

    fill_in :name, with: "Sam"
    fill_in :email, with: "sam@zmail.com"
    fill_in :password, with: "password"
    click_button "Log In"

    expect(current_path).to eq(user_path(user_1.id))
    expect(page).to have_content("Welcome back #{user_1.name}!")
  end

  it 'displays error message if invalid credentials are entered' do 
    visit '/login'

    fill_in :name, with: "Sam"
    fill_in :email, with: "sam@zmail.com"
    fill_in :password, with: "pass"
    click_button "Log In"

    expect(current_path).to eq('/login')
    expect(page).to have_content("Invalid Credentials")
  end 
end