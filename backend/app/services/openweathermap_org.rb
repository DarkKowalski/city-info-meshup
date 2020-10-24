# frozen_string_literal: true

module Meshup
  module OpenWeatherMapOrg
    def self.hash(city)
      url = 'http://api.openweathermap.org/data/2.5/weather?' \
            "q=#{city}&appid=#{Meshup::OPENWEATHERMAP_ORG_KEY}&units=metric"

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
      Meshup::XML.convert(hash(city), 'openWeatherMapMeshup')
    end

    def self.clean(hash)
      return nil if hash.nil?

      result = {}
      begin
        result[:weather] = hash['weather'][0]['description']
        result[:temp] = {
          real: hash['main']['temp'].to_s + '°C',
          feel: hash['main']['feels_like'].to_s + '°C'
        }
      rescue StandardError
        return nil
      end

      result
    end
  end
end
