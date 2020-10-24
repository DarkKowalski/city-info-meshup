# frozen_string_literal: true

module Meshup
  def self.meshup(city)
    xml(city)
  end

  def self.hash(city)
    hash = {}
    hash[:wiki] = Meshup::WikipediaOrg.hash(city)
    hash[:weather] = Meshup::OpenWeatherMapOrg.hash(city)
    hash[:aqi] = Meshup::AqiCn.hash(city)
    hash[:news] = Meshup::NewsApiOrg.hash(city)
    hash
  end

  def self.json(city)
    hash(city).to_json
  end

  def self.xml(city)
    Meshup::XML.convert(hash(city), 'meshup')
  end
end
