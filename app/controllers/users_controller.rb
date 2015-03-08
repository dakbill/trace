class UsersController < ApplicationController

	def dash
		@title = 'Dashboard'
	end

	def upload_data
		@title = 'Upload'
		@data_set = DataSet.new
	end

	def trace_data
		@title = 'Graphs'
		@user = User.find_by_username(session[:username])
		@data_sets = @user.data_sets.all
		@first_data = @data_sets
								.first
								.data_stamps
								.order('record_time')
		@parameter = @first_data.first.parameter
		@unit = @first_data.first.unit
		@first_data = @first_data.pluck('record_time','sensor_value')
	end
	
	def sign_in
		user = params[:user]
		user = User.authenticate(user)
		if user
			session[:username] = user.username
			redirect_to :action => "dash", :controller => :users
		else
			flash[:message] = '<p class="alert alert-warning">dgdf</p>'
			redirect_to :action => "index", :controller => :home
		end
	end

	def sign_out
	end

end
