FactoryGirl.define do 
	factory :user do 
		name "Example User"
		sequence(:email) { |n| "user#{n}@example.com" }
		password "password"
		password_confirmation "password"
	end
end