# frozen_string_literal: true

MESHUP_ROUTE = proc do
  get '/:city' do
    city = params['city']
    Meshup.meshup(city)
  end

  get '/:city/json' do
    city = params['city']
    Meshup.json(city)
  end
end
