# frozen_string_literal: true

NEWS_ROUTE = proc do
  get '/:city' do
    city = params['city']
    Meshup::NewsApiOrg.xml(city)
  end

  get '/:city/json' do
    city = params['city']
    Meshup::NewsApiOrg.json(city)
  end
end
