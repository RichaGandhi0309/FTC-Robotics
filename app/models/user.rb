class User < ActiveRecord::Base
  # attr_accessible :title, :body
def self.create_user!(user)
  session_token=SecureRandom.base64
  User.create! ( {:user_id => user[:user_id], :email => user[:email],  :role => 'Team_Member', :password => user[:password], :session_token => 			session_token, :updatedProfile => 'no'})
end

end
