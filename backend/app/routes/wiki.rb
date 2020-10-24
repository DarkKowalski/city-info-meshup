# frozen_string_literal: true

WIKI_ROUTE = proc do
  get '/:city' do
    city = params['city']
    Meshup::WikipediaOrg.xml(city)
  end

  get '/:city/json' do
    city = params['city']
    Meshup::WikipediaOrg.json(city)
  end
end
