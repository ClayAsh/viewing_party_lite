require 'rails_helper'

RSpec.describe "create party page" do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:user_2) { User.create!(name: "Hank", email: "hank@zmail.com", password: "password" ) } 
  let!(:user_3) { User.create!(name: "Tom", email: "tom@zmail.com", password: "password") }
  let!(:movie_id) { 453395 }

  it "has a form to create party that will be displayed on all invited users dashboards", :vcr do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path

    expect(page).to_not have_content("Doctor Strange in the Multiverse of Madness")

    visit "/discover/movies/#{movie_id}/parties/new"
    

    fill_in 'duration', with: 102
    fill_in 'date', with: '07/09/2022'
    fill_in 'start_time', with: '09:48 PM'

    check 'Hank'
    # check 'Tom'
    click_button 'Create Party'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Doctor Strange in the Multiverse of Madness")

  #   visit user_path(user_2.id)
  #  expect(page).to have_content("Doctor Strange in the Multiverse of Madness")

  #   visit user_path(user_3.id)
  #  expect(page).to_not have_content("Doctor Strange in the Multiverse of Madness")
  end
end