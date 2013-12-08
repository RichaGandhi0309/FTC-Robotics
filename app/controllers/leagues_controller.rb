class LeaguesController < ApplicationController
before_filter :set_current_user
def index
     @leagues = League.all
end

def show
    @league = League.find(params[:id])
    @teams_nos = @league[:team_no].split(',')
    @coach_hash = Hash.new()
    @teams_nos.each do |team_no|
	@team = Team.find_by_team(team_no)
	@coach_hash[@team[:team]] = @team[:main_contact]
    end	    
end



def edit
    @league = League.find(params[:id])
end

  
def create   
 @teams_all= Team.all
 geo_hash= Hash.new()
 geo_hash = generate_geocoded_address(@teams_all)
   leagueNamesArray = ["applebot","kiwibot","bananabot","orangebot","raspbot","cherrybot","rubybot","pumpkinbot","grapebot","lemonbot","limebot","blackbot","yellowbot","pinkbot",
"cocobot","graybot","whitebot","redbot","greenbot","muskbot", "waterbot", "brownbot", "almondbot","cashewbot","walnutbot","rasinbot","honeybot","rainbot","snowbot","flurbot","fallbot","summerbot","winterbot","springbot"]
   i=-1
   # check from Leagues name already exist then do i++ TBD
   @teams_all.each do |team|       	
        @leagueName = String.new()
	@league = Array.new()
	@team_nos = String.new()
	 if team[:league_name] == nil and team[:main_contact_postal_code] !=nil
          i+=1
         @leagueName = leagueNamesArray[i] 
	 @league.push(team[:team])
	 @team_nos.concat("#{team[:team]}")
	 team.update_attributes!(:league_name => @leagueName)
         team.save!         
	 @centre = geo_hash[team[:team]]
	 @teams_all.each do |teamtest|
	   if @league.length < 16 
		    if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !@league.include?(teamtest[:team])
			      @test_if_in_radius = geo_hash[teamtest[:team]]
			      distance = @centre.distance_to(@test_if_in_radius)
                              #sleep(6)
			      if distance <50
				        @league.push(teamtest[:team])
					@team_nos.concat(", #{teamtest[:team]}")
					teamtest.update_attributes!(:league_name => @leagueName)
					teamtest.save!
					#League.create_league!(teamtest[:team],@leagueName)
			      end
		     end
            else
		break
            end            
          end #inner each ends
	puts "#{@team_nos}"
	League.create_league!(@team_nos,@leagueName)
        end	
	
    end #outer do ends
redirect_to teams_path	
end

def generate_geocoded_address(teams)
hash = Hash.new()
teams.each do |team|
#if(team[:main_contact_postal_code] !=nil)
  hash[team[:team]] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
 sleep(6)
#end
end
return hash
end

  # PUT /leagues/1
def update
   @league = League.find(params[:id])
   if !params[:coach_name].nil?    
   @league.update_attributes!(:league_admin => params[:coach_name])
   else
   @league.update_attributes!(params[:league])
   end
   @AdminInfo = Team.find_by_main_contact(params[:coach_name])
   if !@AdminInfo.nil?
   User.create_leagueAdmin!(@AdminInfo)
   end
   redirect_to leagues_path
end


  # DELETE /leagues/1
def destroy
    @league = League.find(params[:id])
    @league.destroy
end

end
