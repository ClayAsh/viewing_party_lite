require 'rails_helper'

RSpec.describe Movie do
  let!(:movie) { MovieFacade.top_movies.first }
  let!(:movie2) { MovieFacade.search_by_id(453395) }

  it 'has attributes', :vcr do

    expect(movie2.id).to eq(453395)
    expect(movie2.title).to eq("Doctor Strange in the Multiverse of Madness")
    expect(movie2.vote_average).to eq(7.5)
  end

  it 'can change minutes into hour:minutes style', :vcr do
    expect(movie2.min_to_hours).to eq('2hr 6min')
  end
end
