class PartiesController < ApplicationController

  def new 
    @movie = MovieFacade.search_by_id(params[:movie_id])
    if current_user 
      @user = User.find(current_user.id)
      @users = User.all 
    else  
      redirect_to "/discover/movies/#{@movie.id}" 
      flash[:error] = "You must be logged in to create a Viewing Party."
    end 
  end

  def create 
    users = User.all
    host = User.find(current_user.id)
    movie = MovieFacade.search_by_id(params[:movie_id])
    party = Party.create({ 
                          duration: params[:duration],
                          date: params[:date],
                          start_time: params[:start_time],
                          movie_id: movie.id,
                          movie_title: movie.title,
                          host: host.id 
                        })   
    users.each do |user|
      if user.id == host.id
        UserParty.create!(user_id: host.id, party_id: party.id)
      elsif params.keys.include?(user.name) && params[user.name.to_sym] == '1'
        UserParty.create!(user_id: user.id, party_id: party.id)
      end
    end
    redirect_to dashboard_path 
  end
end

