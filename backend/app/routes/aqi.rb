# frozen_string_literal: true

AQI_ROUTE = proc do
  get '/:city' do
    city = params['city']
    Meshup::AqiCn.xml(city)
  end

  get '/:city/json' do
    city = params['city']
    Meshup::AqiCn.json(city)
  end
end
