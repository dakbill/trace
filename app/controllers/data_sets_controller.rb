class DataSetsController < ApplicationController
	def get_by_uuid
		uuid =  params[:uuid]
		data = DataSet
						.find_by_uuid(uuid)
						.data_stamps
						.order('record_time')
						.pluck('record_time','sensor_value')
		render :json => data
	end
end
