require 'rails_helper'

RSpec.describe Party, type: :model do
  it { should have_many(:user_parties) }
  it { should have_many(:users).through(:user_parties) }

  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:host) }  
  it { should validate_presence_of(:movie_id) } 
  it { should validate_presence_of(:movie_title) } 

  # it { should validate_numericality_of(:height).is_greater_than_or_equal_to(movie_duration) } 

  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:user_2) { User.create!(name: "Hank", email: "hank@zmail.com", password: "password" ) } 
  let!(:user_3) { User.create!(name: "Tom", email: "tom@zmail.com", password: "password") }
  
  let!(:vp_1) { user_1.parties.create!(duration: 101, date: Date.new(2022,07,20), start_time: '15:00:00', host: user_1.id, movie_id: 453395, movie_title: "Doctor Strange in the Multiverse of Madness" )}

  let!(:user_party_1) { UserParty.create(party_id: vp_1.id, user_id: user_2.id)}
  let!(:user_party_2) { UserParty.create(party_id: vp_1.id, user_id: user_3.id)}

  it 'can take in party and return host name', :vcr do 

    expect(vp_1.host_name).to eq("Sam")
  end

  it 'can return poster path for movie', :vcr do 
    expect(vp_1.get_poster).to eq("/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")
  end
end
