# frozen_string_literal: true

module Meshup
  module WikipediaOrg
    def self.hash(city)
      url = 'https://en.wikipedia.org/w/api.php?' \
            "action=query&list=search&srsearch=#{city}&format=xml"

      begin
        resp = Faraday.get(url)
      rescue StandardError => e
        return nil
      end

      xml = resp.body
      collet(xml)
    end

    def self.json(city)
      hash(city).to_json
    end

    def self.xml(city)
      Meshup::XML.convert(hash(city), 'wikipediaMeshup')
    end

    private

    def self.collet(xml)
      return nil if xml.nil?

      result = {}
      begin
        doc = Nokogiri::XML(xml)
        result[:hits] = doc.at_css('searchinfo').attr('totalhits')
        result[:pages] = []
        doc.xpath('/api/query/search/p').each do |page|
          result[:pages].push(
            { title: page.attr('title'),
              word: page.attr('wordcount') }
          )
        end
      rescue StandardError
        return nil
      end

      result
    end
  end
end
