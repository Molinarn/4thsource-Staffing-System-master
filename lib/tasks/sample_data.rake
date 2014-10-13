require 'faker'
#namespace :db do
#desc "Fill database with sample data" 
#  task :populate => :production do
#    require 'faker'
#    Rake::Task['db:reset'].invoke
#    User.create!(:name => "Example User",
#                 :email => "example@railstutorial.org",
#                 :password => "foobar",
#                 :password_confirmation => "foobar")
#    99.times do |n|
#      name = Faker::Name.name
#      email = "example-#{n+1}@railstutorial.org" 
#      password = "password"
#      User.create!(:name => name,
#                   :email => email,
#                   :password => password,
#                   :password_confirmation => password)
#    end 
#  end
#end

namespace :db do
  desc "Fill database with sample data" 
  task :populate => :environment do
    User.all(:limit => 6).each do |user|
      user_inc = user.id + 1
      10.times do
        user.followings.create!(:follow_user => user_inc)
        user_inc = user_inc + 1
      end 
    end
  end 
end
