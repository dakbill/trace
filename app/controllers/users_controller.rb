require 'csv'
class UsersController < ApplicationController

	def dash
		@title = 'Dashboard'
	end

	def upload_data
		@title = 'Upload'
		@data_set = DataSet.new

	end

	def save_uploaded_data
		name = params[:data_set][:name]
		d_set = DataSet.create(name:name)
		data_set_file = params[:data_set][:data_set_file]
		csv_text = data_set_file.read
		csv = CSV.parse(csv_text, :headers => true)
		d_stamps = []
		csv.each do |row|
		  d_stamps.push (DataStamp.create(row.to_hash))
		end
		d_set.data_stamps << d_stamps
		user = User.find_by_username(session[:username])
		user.data_sets << d_set
		flash[:message] = '<p class="alert alert-success">DataSet was succesfully saved</p>'
		redirect_to action: 'upload_data',controller: :users
	end

	def trace_data
		@title = 'Graphs'
		@user = User.find_by_username(session[:username])
		@data_sets = @user.data_sets.all
		@first_data = @data_sets.first
		if @first_data
			@data_stamps = @first_data
								.data_stamps
								.order(:record_time)
								.group(:record_time)
			if @data_stamps
				@parameter = @data_stamps.first.parameter
				@unit = @data_stamps.first.unit
				@first_data = @data_stamps.pluck('record_time','sensor_value')	
			end
		end
		
	end
	
	def sign_in
		user = params[:user]
		user = User.authenticate(user)
		if user
			session[:username] = user.username
			redirect_to :action => "dash", :controller => :users
		else
			flash[:message] = '<p class="alert alert-warning">Incorrect username or password!</p>'
			redirect_to :action => "index", :controller => :home
		end
	end

	def sign_out
	end

end
