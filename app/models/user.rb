class User < ActiveRecord::Base
	has_and_belongs_to_many :data_sets

	def self.authenticate(user_details)
		user = User.find_by_username(user_details[:username])
		return nil if user.nil?
		return user if user.has_password?(user_details[:password])
		return nill
	end

	def has_password?(submitted_password)
		submitted_password == password
	end

	
end
