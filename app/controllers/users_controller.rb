class UsersController < ApplicationController
before_filter :set_current_user
def index
  #default page
end

def create
 #default page
end

def show
@league = League.find_by_league_admin(params[:id])
 #default page
end

end
