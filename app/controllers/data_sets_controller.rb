class DataSetsController < ApplicationController
	def get_by_uuid
		uuid =  params[:uuid]
		data = DataSet
						.find_by_uuid(uuid)
						.data_stamps
						.order('record_time')
		parameter = data.first.parameter
		unit = data.first.unit
		data = data.pluck('record_time','sensor_value')
		render :json => {data_points:data,parameter:parameter,unit:unit}
	end
end
