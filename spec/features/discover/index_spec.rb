require 'rails_helper'

RSpec.describe 'Disover index page' do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }

  it 'has button to discover top rated movies', :vcr do 
    visit user_discover_index_path(user_1.id)

    click_button "Discover Top Rated Movies"

    expect(current_path).to eq(user_movies_path(user_1.id))
  end

  it 'has search form for movie title', :vcr do 
    visit user_discover_index_path(user_1.id)

    fill_in :keyword, with: "Doctor Strange"
    click_button 'Search'

    expect(current_path).to eq(user_movies_path(user_1.id))
  end

end