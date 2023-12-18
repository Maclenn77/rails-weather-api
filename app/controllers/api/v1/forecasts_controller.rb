module Api
  module V1
    class ForecastsController < ApplicationController
      before_action :get_data, only: [:index]

      def index
        render json: { cities: @results }
      end
    end
  end
end

# Path: app/controllers/api/v1/forecasts_controller.rb
def get_data
  query = params[:q]

  if query
    logger = create_logger
    conn = Faraday::Connection.new('https://search.reservamos.mx/api/v2', { ssl: { verify: false } })
    response = conn.get("places?q=#{query}")
    data = JSON.parse(response.body)
    @results = data.map do |city|

      Rails.logger.info "Getting forecast for #{city['city_name']}"

      { city: city['city_name'], state: city['state'], country: city['country'],
        lat: city['lat'], long: city['long'], forecasts: [ get_forecast(city["lat"], city["long"])] }
    end
  else
    @results = []
  end

  # Get forecast from OpenWeatherMap API
  def get_forecast(lat, long)
    conn = Faraday::Connection.new('https://api.openweathermap.org/data/2.5', { ssl: { verify: false } })
    response = conn.get("onecall?lat=#{lat}&lon=#{long}&exclude=hourly,minutely&appid=#{ENV['OW_API_KEY']}&units=metric&lang=es")
    
    if response.status != 200
      error_message = JSON.parse(response.body)['message']
      return { error: error_message }
    else
      data = JSON.parse(response.body)
      
      data['daily'].map { |day| { date: Time.at(day['dt']).strftime('%d/%m/%Y'),
                                          min_temperature: day['temp']['min'], 
                                          max_temperature: day['temp']['max'] 
                                          } 
                                        }
  end

  private

end
