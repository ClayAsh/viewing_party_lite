require 'rails_helper'

RSpec.describe "User Login form" do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password") }
  let!(:user_2) { User.create!(name: "Bob", email: "bob@zmail.com", password: "password", roll: 1) }

  it 'can check user credentials and log them in' do 
    visit login_path

    fill_in :name, with: "Sam"
    fill_in :email, with: "sam@zmail.com"
    fill_in :password, with: "password"
    click_button "Log In"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome back #{user_1.name}!")
  end

  it 'displays error message if invalid credentials are entered' do 
    visit login_path

    fill_in :name, with: "Sam"
    fill_in :email, with: "sam@zmail.com"
    fill_in :password, with: "pass"
    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid Credentials")
  end 

  it 'directs to admin dashboard if user is admin' do 
    visit login_path 
    fill_in :name, with: "Bob"
    fill_in :email, with: "bob@zmail.com"
    fill_in :password, with: "password"
    click_button "Log In"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Welcome back #{user_2.name}!")
  end

  it 'directs to root path if user is default and tries to view admin page' do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit admin_dashboard_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("The page you are trying to view cannot be found.")
  end
end