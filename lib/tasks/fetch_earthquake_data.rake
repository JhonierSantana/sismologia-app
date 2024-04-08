namespace :fetch_earthquake_data do
  desc "Fetch earthquake data from USGS"
  task earthquake_data: :environment do
    puts "Fetching earthquake data..."

    require 'httparty'

    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    
    begin
      response = HTTParty.get(url)

      unless response.success?
        puts "Error: USGS feed data could not be obtained."
        return
      end

      data = JSON.parse(response.body)
      
      features_count = data['features'].size
      puts "Total features to process: #{features_count}"

      data['features'].each_with_index do |feature, index|
        puts "Processing feature #{index + 1} of #{features_count}..."

        attributes = feature['properties']
        coordinates = feature['geometry']['coordinates']

        next unless attributes['id'] && attributes['mag'] && attributes['place'] && attributes['magType'] && coordinates[0] && coordinates[1]

        earthquake = Earthquake.find_or_initialize_by(external_id: attributes['id'])

        earthquake.assign_attributes(
          magnitude: attributes['mag'],
          place: attributes['place'],
          time: Time.at(attributes['time'] / 1000),
          url: attributes['url'],
          tsunami: attributes['tsunami'],
          mag_type: attributes['magType'],
          title: attributes['title'],
          longitude: coordinates[0],
          latitude: coordinates[1]
        )

        if earthquake.save
          puts "Earthquake data saved: #{earthquake.title}"
        else
          puts "Error: The seismic event could not be saved."
        end
      end

      puts "Fetching earthquake data completed."
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end
