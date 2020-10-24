# frozen_string_literal: true

module Meshup
  module AqiCn
    def self.hash(city)
      url = "http://api.waqi.info/feed/#{city}/" \
            "?token=#{Meshup::AQICN_ORG_KEY}"

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
      Meshup::XML.convert(hash(city), 'aqiCnMeshup')
    end

    def self.clean(hash)
      return nil if hash.nil?

      result = {}
      begin
        result[:aqi] = hash['data']['aqi']
        result[:idx] = hash['data']['idx']
        result[:pollution] = hash['data']['dominentpol']
      rescue StandardError
        return nil
      end

      result
    end
  end
end
