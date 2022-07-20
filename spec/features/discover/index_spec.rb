require 'rails_helper'

RSpec.describe 'Disover index page' do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }

  it 'has button to discover top rated movies', :vcr do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit discover_path

    click_button "Discover Top Rated Movies"

    expect(current_path).to eq(discover_movies_path)
  end

  it 'has search form for movie title', :vcr do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit discover_path

    fill_in :keyword, with: "Doctor Strange"
    click_button 'Search'

    expect(current_path).to eq(discover_movies_path)
  end
end