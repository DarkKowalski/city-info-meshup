# frozen_string_literal: true

class Route < Sinatra::Base
  set :show_exceptions, :after_handler
  register Sinatra::Namespace
  use Rack::Cors do
    allow do
      origins '*'
      resource '/*',
               methods: %i[get post delete put patch options head],
               headers: :any,
               expose: ['Token'],
               max_age: 600
    end
  end

  namespace '/', &ROOT_ROUTE
  namespace '/meshup', &MESHUP_ROUTE
  namespace '/weather', &WEATHER_ROUTE
  namespace '/wiki', &WIKI_ROUTE
  namespace '/news', &NEWS_ROUTE
  namespace '/aqi', &AQI_ROUTE

  error 500 do |error|
    [
      500,
      Gyoku.xml(
        {
          exception: error.class,
          message: error.message,
          backtrace: error.backtrace
        }
      )
    ]
  end

  error BaseError, &:rack
end
