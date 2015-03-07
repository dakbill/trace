class HomeController < ApplicationController
	def index
		@title = 'Welcome'
		@user = User.new
	end
end
