namespace :fetch_earthquake_data do
  desc "Fetch earthquake data from USGS"
  task earthquake_data: :enviroment do 
	  require 'httparty'

	  url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
		response = HTTParty.get(url)

		if response.success?
			data = JSON.parse(response.body)

			data['features'].each do |feature|
				attributes = feature['properties']
				coordinates = feature['geometry']['coordinates']

				
end
