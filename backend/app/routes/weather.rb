# frozen_string_literal: true

WEATHER_ROUTE = proc do
  get '/:city' do
    city = params['city']
    Meshup::OpenWeatherMapOrg.xml(city)
  end

  get '/:city/json' do
    city = params['city']
    Meshup::OpenWeatherMapOrg.json(city)
  end
end
