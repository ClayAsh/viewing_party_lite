require 'rails_helper'

RSpec.describe "Movie index" do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:movie_id) { 453395 }
  it 'has movie title and vote average of movie', :vcr do 
    visit user_movies_path(user_1.id)

    expect(page).to have_content("Doctor Strange")
    expect(page).to have_content(7.5)
    #need expect for limit 40 
  end

  it 'has link to movie show page', :vcr do 
    visit user_movies_path(user_1.id)

    click_link "Doctor Strange in the Multiverse of Madness"

    expect(current_path).to eq(user_movie_path(user_1.id, movie_id))
  end
end