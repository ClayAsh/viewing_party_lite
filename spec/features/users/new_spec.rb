require 'rails_helper'

RSpec.describe 'register page' do
  it 'allows a user to create a registration and redirects to their page' do

    visit '/registration'

    expect(page).to have_content("Name")
    expect(page).to have_content("Email")
    expect(page).to have_button("Register")

    fill_in "Name", with: "Sam Smith"
    fill_in "Email", with: "ssmith22@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Register"

    expect(current_path).to eq("/users/#{User.last.id}")
    expect(page).to have_content("Welcome Sam Smith!")
  end

  it 'redirects to register page and shows error message if invalid info is entered' do 
    visit '/registration'
     
    fill_in "Name", with: "Sam Smith"
    fill_in "Email", with: "ssmith22@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "pass"
    click_button "Register"

    expect(current_path).to eq('/registration')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
