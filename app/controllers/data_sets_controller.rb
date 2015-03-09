class DataSetsController < ApplicationController
	def get_by_id
		id =  params[:id]
		data = DataSet
						.find(id)
						.data_stamps
						.order('record_time')
		if data
			parameter = data.first.parameter
			unit = data.first.unit
			data = data.pluck('record_time','sensor_value')
			render :json => {data_points:data,parameter:parameter,unit:unit}
		else
			render :json => {message:"Dataset with uuid #{uuid} was not found"}
		end
	end
end
