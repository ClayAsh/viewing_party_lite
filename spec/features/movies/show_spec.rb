require 'rails_helper'

RSpec.describe 'movies show page' do
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:movie_id) { 453395 }

  it 'can see a button for creating view party and to return to discover page', :vcr do

    visit user_movie_path(user_1.id, movie_id)

    expect(page).to have_button("Create Viewing Party")
    expect(page).to have_button("Discover Movies")
    click_button "Discover Movies"
    expect(current_path).to eq(user_discover_index_path(user_1.id))
  end

  it 'can find the movie info', :vcr do
    visit user_movie_path(user_1.id, movie_id)

    expect(page).to have_content("Doctor Strange in the Multiverse of Madness")
    expect(page).to have_content("Vote Average: 7.5")
    expect(page).to have_content("Runtime: 2hr 6min")
    expect(page).to have_content("Genres: Fantasy, Action, Adventure")
    expect(page).to have_content("Summary: Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.") #Overview tag
    expect(page).to have_content("Benedict Cumberbatch")
    expect(page).to have_content("Elizabeth Olsen")
    expect(page).to_not have_content("Rachel McAdams")
    expect(page).to have_content("Total Reviews: 4")
    expect(page).to have_content("Review's Details")
    expect(page).to have_content("Name - Chris Sawin, Username - ChrisSawin, Rating - 7.0")
  end
end
