class UsersController < ApplicationController
before_filter :set_current_user 

def index
  check_access_user_global 
  #default page
end

def create
 #default page
end

def show
<<<<<<< HEAD
@league = League.find_by_league_admin(params[:id])

=======
 check_access_user_Admins
 @league = League.find_by_league_admin(params[:id])
>>>>>>> 10aa0673f8947e4394f448a056fc42d3e1dd4dda
 #default page
end

end
