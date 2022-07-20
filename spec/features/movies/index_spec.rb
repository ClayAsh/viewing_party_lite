require 'rails_helper'

RSpec.describe "Movie index" do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:movie_id) { 453395 }
  it 'has movie title and vote average of movie', :vcr do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit discover_movies_path

    expect(page).to have_content("Doctor Strange")
    expect(page).to have_content(7.5)
    #need expect for limit 40 
  end

  it 'has link to movie show page', :vcr do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit discover_movies_path

    click_link "Doctor Strange in the Multiverse of Madness"

    expect(current_path).to eq("/discover/movies/#{movie_id}")
  end
end