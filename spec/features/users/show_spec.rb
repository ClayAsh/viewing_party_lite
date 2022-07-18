require 'rails_helper'

RSpec.describe "User Dashboard" do 
  let!(:user_1) { User.create!(name: "Sam", email: "sam@zmail.com", password: "password" ) }
  let!(:user_2) { User.create!(name: "Hank", email: "hank@zmail.com", password: "password" ) } 
  let!(:user_3) { User.create!(name: "Tom", email: "tom@zmail.com", password: "password") }

  let!(:vp_1) { user_1.parties.create!(duration: 101, date: Date.new(2022,07,20), start_time: '15:00:00', host: user_1.id, movie_id: 123, movie_title: "Doctor Strange in the Multiverse of Madness" )}
  let!(:vp_2) { user_2.parties.create!(duration: 101, date: Date.new(2022,07,21), start_time: '16:00:00', host: user_2.id, movie_id: 345, movie_title: "Strange Brew" )}
  let!(:vp_3) { user_3.parties.create!(duration: 101, date: Date.new(2022,07,22), start_time: '17:00:00', host: user_3.id, movie_id: 678, movie_title: "Love Is Strange" )}

  let!(:user_party_1) { UserParty.create(party_id: vp_1.id, user_id: user_2.id)}

  let!(:user_party_3) { UserParty.create(party_id: vp_2.id, user_id: user_1.id)}
  let!(:user_party_4) { UserParty.create(party_id: vp_2.id, user_id: user_3.id)}

  let!(:user_party_5) { UserParty.create(party_id: vp_3.id, user_id: user_2.id)}
  let!(:user_party_6) { UserParty.create(party_id: vp_3.id, user_id: user_1.id)}

  let!(:movie) { MovieFacade.search_by_id(453395) }

  it "Has users name in heading", :vcr do 
    visit user_path(user_1.id)

    expect(page).to have_content("#{user_1.name}'s Dashboard")
  end

  it "has button to discover movies", :vcr do 
    visit user_path(user_1.id)

    click_button "Discover Movies"

    expect(current_path).to eq(user_discover_index_path(user_1.id))
  end

  it "has section that shows viewing parties invited to", :vcr do 
    visit user_path(user_2.id)

    expect(page).to have_content("Viewing Party Invitations")

    within("#invitations-#{vp_1.id}") do 
      expect(page).to have_content(vp_1.movie_title)
      expect(page).to have_content(vp_1.date.strftime("%d/%m/%Y") )
      expect(page).to have_content(vp_1.start_time.strftime("%I:%M %p"))
      expect(page).to have_content(vp_1.duration)
      expect(page).to have_content("Party Host: #{user_1.name}")
      expect(page).to have_content("Users Invited: #{user_1.name} #{user_2.name}")
      expect(page).to_not have_content(user_3.name)
    end 

    within("#invitations-#{vp_3.id}") do 
      expect(page).to have_content(vp_3.movie_title)
      expect(page).to have_content(vp_3.date.strftime("%d/%m/%Y") )
      expect(page).to have_content(vp_3.start_time.strftime("%I:%M %p"))
      expect(page).to have_content(vp_3.duration)
      expect(page).to have_content("Party Host: #{user_3.name}")
      expect(page).to have_content("Users Invited: #{user_1.name} #{user_2.name} #{user_3.name}")
    end 
  end

  it 'has section that shows viewing parties user is hosting', :vcr do 
    visit user_path(user_1.id)

    expect(page).to have_content("Viewing Parties I am Hosting")

    within("#hosting-#{vp_1.id}") do 
  
    expect(page).to have_content(vp_1.movie_title)
    expect(page).to have_content(vp_1.date.strftime("%d/%m/%Y") )
    expect(page).to have_content(vp_1.start_time.strftime("%I:%M %p"))
    expect(page).to have_content("Party Host: #{user_1.name}")
    expect(page).to have_content("Users Invited: #{user_2.name}")    
    expect(page).to_not have_content(user_3.name)    
    end 
  end
end