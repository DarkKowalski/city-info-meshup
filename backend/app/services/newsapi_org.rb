# frozen_string_literal: true

module Meshup
  module NewsApiOrg
    def self.hash(city)
      url = "http://newsapi.org/v2/everything?q=#{city}" \
            "&apiKey=#{Meshup::NEWSAPI_ORG_KEY}"

      begin
        resp = Faraday.get(url)
      rescue StandardError => e
        return nil
      end

      hash = JSON.parse(resp.body)
      clean(hash)
    end

    def self.json(city)
      hash(city).to_json
    end

    def self.xml(city)
      Meshup::XML.convert(hash(city), 'newsApiMeshup')
    end

    def self.clean(hash)
      return nil if hash.nil?

      result = {}

      begin
        result[:total] = hash['totalResults']
        result[:articles] = []
        hash['articles'].each do |article|
          result[:articles].push(
            {
              source: article['source']['name'],
              description: article['description'],
              date: article['publishedAt'],
              url: article['url']
            }
          )
        end
      rescue StandardError
        return nil
      end

      result
    end
  end
end
