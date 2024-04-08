class Api::EarthquakesController < ApplicationController
    def index
      page = params.fetch(:page, 1).to_i
      per_page = [params.fetch(:per_page, 25).to_i, 1000].min
      mag_types = params[:filters] ? params[:filters][:mag_type] : nil
      total = mag_types ? Earthquake.where(mag_type: mag_types).count : Earthquake.count
      offset = (page - 1) * per_page
  
      if mag_types
        earthquakes = Earthquake.where(mag_type: mag_types).offset(offset).limit(per_page).map do |earthquake|
          format_earthquake(earthquake)
        end
      else
        earthquakes = Earthquake.offset(offset).limit(per_page).map do |earthquake|
          format_earthquake(earthquake)
        end
      end
  
      render json: {
        data: earthquakes,
        pagination: {
          current_page: page,
          total: total,
          per_page: per_page
        }
      }
    end
  
    private
  
    def format_earthquake(earthquake)
      {
        id: earthquake.id,
        type: 'feature',
        attributes: {
          external_id: earthquake.external_id,
          magnitude: earthquake.magnitude.to_f,
          place: earthquake.place,
          time: earthquake.time.iso8601,
          tsunami: earthquake.tsunami,
          mag_type: earthquake.mag_type,
          title: earthquake.title,
          coordinates: {
            longitude: earthquake.longitude.to_f,
            latitude: earthquake.latitude.to_f
          }
        },
        links: {
          external_url: earthquake.url
        }
      }
    end
  end
  