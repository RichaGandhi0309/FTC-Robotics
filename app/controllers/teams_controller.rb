class TeamsController < ApplicationController
before_filter :set_current_user

require 'geokit-rails'

 def index
  @teams= Team.all  
 end
 def edit
 # default: render 'edit' template
 end
  def new
    # default: render 'new' template
  end
 def show
 # default: render 'show' template
 end

 def create
   @team = Team.create_team!(params[:team])
   @user = User.create_user!(params[:team])
   if @team.save
	flash[:notice] = "Welcome #{@team.team}. Your account has been created"	
	redirect_to login_path	
  
   else
	flash[:notice] = " Sorry -- #{@team.errors.full_messages}.Try again"
	redirect_to new_team_path
   end
 end

def create_leagues
@teams_all= Team.all
geo_hash= Hash.new()
 geo_hash = generate_geocoded_address(@teams_all)
###########################################################
 #@league1 = Array.new()
 # @teams = Team.find_by_id('16')
  #@teams_all = Team.all
   leagueNamesArray = ["applebot","kiwibot","bananabot","orangebot","raspbot","cherrybot","rubybot","pumpkinbot","grapebot","lemonbot","limebot"]
   i=0
   # check from Leagues name already exist then do i++ TBD
   @teams_all.each do |team| 
        @leagues = Array.new()
        @leagueName = leagueNamesArray[i]  
	i+=1
	#leagueNamesArray[i] = Array.new()
        @league = Array.new()
	if team[:league_name] == nil and team[:main_contact_postal_code] !=nil
	 @league.push(team[:team])
	 team.update_attributes!(:league_name => @leagueName)
         team.save!
	 @centre = geo_hash[team[:team]]
	 @teams_all.each do |teamtest|
		   if @league.length < 16 
		    if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !@league.include?(teamtest[:team])
			      @test_if_in_radius = geo_hash[teamtest[:team]]
			      distance = @centre.distance_to(@test_if_in_radius)
			      if distance <50
                                  #if @league.length < 16
					@league.push(teamtest[:team])
					teamtest.update_attributes!(:league_name => @leagueName)
                      			#@leagues.push(@league) # Push in leagues table TBD
			                 #i=i+1
			                
			          end
			      end
			else
				@leagues.push(@league) # Push in leagues table TBD
			        #i=i+1
				break
			#end
		     end
            
          end #inner each ends
        end	
	@leagues.push(@league)
    end #outer do ends
#puts @leagues
flash[:notice] = "Leagues--- #{@leagues}"
redirect_to teams_path	
##########################################
      #distance = hashes[6072].distance_to(hashes[5063])
	#flash[:notice] = "Welcome #{distance}. Your account has been created"
#redirect_to users_path
end

def generate_geocoded_address(teams)
hash = Hash.new()
teams.each do |team|
  hash[team[:team]] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
end
return hash
end


 def import  
  if(params[:file] == nil)
	flash[:notice] ="Sorry! No file selected. Please select a file and try again."
	redirect_to users_path
  else
       teams = Team.upload(params[:file].path)     
       teams.each do |team|
	       if !(team.errors).empty?
                @message = String.new ("Hi!!")
		@message.concat("Sorry --#{team.team} was not added because of following erros #{team.errors.full_messages}.")
	       end
       end
        if @message.nil?
        flash[:notice] = "Team data Uploaded"
        redirect_to teams_path
        else
        flash[:notice] = "#{@message}.Please try again"
	redirect_to teams_path      
        end
  end
end

def update
    @team = Team.find params[:team]
    @team.update_attributes!(params[:team])
    flash[:notice] = "Profile was successfully updated."
    redirect_to team_path(@team)
  end

end
