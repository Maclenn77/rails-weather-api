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
  query = params[:query]

  if query
    conn = Faraday::Connection.new('https://search.reservamos.mx/api/v2', { ssl: { verify: false } })
    response = conn.get("places?q=#{query}")
    data = JSON.parse(response.body)
    @results = data.map do |city|
      { city: city['city_name'], state: city['state'], country: city['country'],
        lat: city['lat'], long: city['long'], forecasts: [] }
    end
  else
    @results = []
  end
end
