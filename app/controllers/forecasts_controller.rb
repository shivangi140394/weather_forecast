class ForecastsController < ApplicationController
  def index
    user  = User.find(params[:user_id])
    location = user.city
    response = HTTParty.get("http://api.weatherapi.com/v1/current.json?key=#{ENV['WEATHER_FORCAST']}&q=#{location}")
    @weather_data = JSON.parse(response.body)
  end
end
