# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teams = [{:team => '456', :organization => 'UIowa', :city => 'Iowa', :state => 'Iowa', :date_registered => '5-Nov-2013'}]

teams.each do |t|
Team.create!(t)
end

users =[{:user_id => 'Becca', :role => 'Global_Admin', :password => 'becca'},
	 {:user_id => '1234', :role => 'Team_Member', :password => '1234'}
	]
users.each do |user|
   User.create!(user)
end

