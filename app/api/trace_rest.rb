module TraceRest
	class API < Grape::API

		desc "Pings the server."
		get :ping do
			{message: "pong"}
		end

		desc "Upload log data."
		params do
	    	requires :uuid, type: String, desc: "A unique identifier for the log."
	    	requires :parameter, type: String, desc: "The type of environmental parameter being monitored."
	    	requires :record_time, type: DateTime, desc: "The time the data was recorded."
	    	requires :channel, type: Integer, desc: "The channel on the device from which the data was recorded."
	    	requires :sensor_value, type: Float, desc: "The reading on the sensor."
	    	requires :unit, type: String, desc: "The unit of the sensor's readings."
	    	
	    end
		post :upload_data do
			data_stamp = DataStamp.new(
				parameter:params[:parameter],
				record_time:params[:record_time],
				channel:params[:channel],
				sensor_value:params[:sensor_value],
				unit:params[:unit]
			)
			data_set = DataSet.find_by_uuid(params[:uuid])
			if data_set
				data_stamp.save
				data_set.data_stamps << data_stamp
				{ message:"Data recorded into log uuid: #{params[:uuid]}." }
			else
				{ message:"Dataset with uuid: #{params[:uuid]} was not found." }
			end
			
		end

	end
end
