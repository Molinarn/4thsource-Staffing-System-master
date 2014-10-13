#Factory.define :user do |user|
FactoryGirl.define do
  factory :user, :class => User do
    name			"Michael Hartl"
    email			"mhartl@example.com"
    password			"foobar"
    password_confirmation	"foobar"
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end
end

#Factory.sequence :email do |n| 
#  "person-#{n}@example.com"
#end

FactoryGirl.define do
  factory :micropost, :class => Micropost do
    content                    "Foo bar"
    association                :user
  end
end
